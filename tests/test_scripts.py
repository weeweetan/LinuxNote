"""Behavioral regressions; network tools are replaced with local test doubles."""
import json
import os
import platform
import shutil
import subprocess
import sys
import tempfile
import time
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASH = shutil.which('bash')


class ScriptTests(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.work = Path(self.temporary.name)
        self.bin = self.work / 'bin'
        self.bin.mkdir()
        self.env = dict(os.environ, PATH=f'{self.bin}{os.pathsep}{os.environ["PATH"]}', LC_ALL='C')
        self.env['TEST_LOG'] = str(self.work / 'commands.jsonl')

    def fake(self, name, body):
        path = self.bin / name
        path.write_text(f'#!{sys.executable}\n' + body, encoding='utf-8')
        path.chmod(0o755)

    def run_script(self, name, *args, input='', expected=0, timeout=6):
        result = subprocess.run([BASH, str(ROOT / 'bash-shell' / name), *args], input=input,
                                text=True, capture_output=True, cwd=self.work, env=self.env, timeout=timeout)
        self.assertEqual(result.returncode, expected, f'{name}: stdout={result.stdout!r} stderr={result.stderr!r}')
        return result

    def command_log(self):
        return [json.loads(line) for line in Path(self.env['TEST_LOG']).read_text().splitlines()]

    def test_sum_decimal_zero_and_interactive(self):
        for value, total in [('0', 0), ('08', 36), ('100', 5050)]:
            with self.subTest(value=value):
                self.assertIn(f'= {total}\n', self.run_script('sum-range.sh', value).stdout)
        self.assertIn('= 15\n', self.run_script('sum-range.sh', input='5\n').stdout)

    def test_sum_rejects_negative_oversize_and_expressions(self):
        for value in ['-1', '1000001', '1+2', '1.5', '', '9' * 100, 'x[$(touch injected)]']:
            with self.subTest(value=value):
                self.run_script('sum-range.sh', value, expected=2)
        self.assertFalse((self.work / 'injected').exists())

    def test_multiply_accepts_decimal_and_negative(self):
        self.assertIn('= -96\n', self.run_script('multiply-integers.sh', '-12', '008').stdout)
        self.assertIn('= 0\n', self.run_script('multiply-integers.sh', '-000', '9').stdout)

    def test_multiply_rejects_oversize_and_arithmetic_injection(self):
        for value in ['1000000000', '1+2', 'x[$(touch injected)]']:
            self.run_script('multiply-integers.sh', value, '1', expected=2)
        self.assertFalse((self.work / 'injected').exists())

    def test_pi_validates_before_invoking_bc(self):
        self.fake('bc', 'import sys\nprint(sys.stdin.read().strip())\n')
        self.assertIn('scale=10; 4*a(1)', self.run_script('calculate-pi.sh', '00010').stdout)
        for value in ['9', '10001', '10;quit', '-1']:
            self.run_script('calculate-pi.sh', value, expected=2)

    def test_interactive_scripts_exit_on_eof(self):
        for name in ['sum-range.sh', 'multiply-integers.sh', 'calculate-pi.sh', 'date-countdown.sh',
                     'check-file-permissions.sh', 'create-dated-files.sh', 'read-full-name.sh']:
            with self.subTest(name=name):
                self.run_script(name, expected=2)
        self.run_script('wait-for-yes.sh', expected=1)
        self.assertEqual(self.run_script('wait-for-yes.sh', input='no\nyes\n').stdout, 'OK.\n')

    def test_filenames_with_spaces_and_dangling_symlink(self):
        (self.work / 'a file.txt').write_text('hello')
        self.assertIn('regular file', self.run_script('check-file-permissions.sh', 'a file.txt').stdout)
        (self.work / 'dangling link').symlink_to('absent')
        self.assertIn('symbolic link', self.run_script('check-file-permissions.sh', 'dangling link').stdout)
        self.run_script('check-file-permissions.sh', 'absent', expected=1)
        self.run_script('check-file-permissions.sh', '', expected=2)

    def test_parameter_boundaries_and_literal_backslash(self):
        output = self.run_script('show-arguments.sh', 'a b', r'c\d').stdout
        self.assertIn('<a b>\n<c\\d>\n', output)
        output = self.run_script('read-full-name.sh', input='a\\b\nc d\n').stdout
        self.assertIn('a\\b c d', output)

    def test_date_logging_is_finite_and_appends(self):
        self.fake('sleep', 'pass\n')
        self.run_script('log-timestamps.sh', '3', '1', 'a log.txt')
        self.run_script('log-timestamps.sh', '1', '1', 'a log.txt')
        self.assertEqual(len((self.work / 'a log.txt').read_text().splitlines()), 4)
        self.run_script('log-timestamps.sh', '0', expected=2)

    @unittest.skipUnless(platform.system() == 'Linux' or shutil.which('gdate'), 'requires GNU date')
    def test_real_calendar_dates_and_file_creation(self):
        self.run_script('date-countdown.sh', '20300230', expected=2)
        self.assertIn('ago', self.run_script('date-countdown.sh', '20000101').stdout)
        self.run_script('create-dated-files.sh', 'with spaces-')
        self.assertEqual(len(list(self.work.glob('with spaces-*'))), 3)

    def test_ifcfg_prints_without_writing(self):
        before = set(self.work.iterdir())
        result = self.run_script('generate-ifcfg.sh', 'eth0', '02:00:00:00:00:01', '192.0.2.10', '255.255.255.0')
        self.assertIn('IPADDR=192.0.2.10\n', result.stdout)
        self.assertEqual(set(self.work.iterdir()), before)

    def test_ifcfg_rejects_invalid_or_injectable_values(self):
        for interface, address, mask in [('eth0\nONBOOT=no', '192.0.2.1', '255.255.255.0'),
                                         ('eth0', '999.0.2.1', '255.255.255.0'),
                                         ('eth0', '192.000.2.1', '255.255.255.0'),
                                         ('eth0', '192.0.2.1', '255.0.255.0')]:
            result = self.run_script('generate-ifcfg.sh', interface, '02:00:00:00:00:01', address, mask, expected=2)
            self.assertEqual(result.stdout, '')

    def test_exact_ports_ipv4_ipv6_and_no_shared_temporary_file(self):
        self.fake('ss', "print('LISTEN 0 128 0.0.0.0:8080 0.0.0.0:*')\nprint('LISTEN 0 128 [::]:22 [::]:*')\n")
        output = self.run_script('check-listening-ports.sh').stdout
        self.assertIn('TCP/80 is not listening\n', output)
        self.assertIn('TCP/22 is listening\n', output)
        self.assertEqual(set(p.name for p in self.work.iterdir()), {'bin'})

    def test_netstat_fallback(self):
        self.env['PATH'] = str(self.bin)
        (self.bin / 'awk').symlink_to(shutil.which('awk'))
        self.fake('netstat', "print('tcp 0 0 0.0.0.0:80 0.0.0.0:* LISTEN')\nprint('tcp6 0 0 :::25 :::* LISTEN')\n")
        output = self.run_script('check-listening-ports.sh').stdout
        self.assertIn('TCP/80 is listening\n', output)
        self.assertIn('TCP/25 is listening\n', output)

    def test_socket_command_failure_propagates(self):
        self.fake('ss', 'import sys\nsys.exit(1)\n')
        self.run_script('check-listening-ports.sh', expected=1)

    def test_ping_requires_valid_explicit_target(self):
        for args in [(), ('256.0.0',), ('192.0.2', '0', '3'), ('192.0.2', '3', '2')]:
            self.run_script('ping-range.sh', *args, expected=2)

    def test_ping_reports_no_reply_without_claiming_host_is_down(self):
        self.fake('ping', 'import sys\nsys.exit(0 if sys.argv[-1].endswith(".1") else 1)\n')
        result = self.run_script('ping-range.sh', '192.0.2', '1', '2', expected=1)
        self.assertIn('192.0.2.1 REPLY', result.stdout)
        self.assertIn('192.0.2.2 NO_REPLY', result.stdout)

    def setup_tls(self):
        self.fake('timeout', 'import subprocess, sys\nsys.exit(subprocess.call(sys.argv[2:]))\n')
        self.fake('openssl', '''import json, os, sys
with open(os.environ['TEST_LOG'], 'a') as log:
    log.write(json.dumps(sys.argv[1:]) + '\\n')
if sys.argv[1] == 's_client':
    print('mock certificate')
    sys.exit(int(os.environ.get('TLS_FAILURE', '0')))
sys.stdin.read()
print('sha256 Fingerprint=MOCK')
''')

    def test_tls_sets_sni_verification_and_sha256(self):
        self.setup_tls()
        self.run_script('inspect-tls.sh', 'example.com', '443')
        calls = self.command_log()
        client = next(call for call in calls if call[0] == 's_client')
        self.assertIn('-verify_return_error', client)
        self.assertEqual(client[client.index('-servername') + 1], 'example.com')
        self.assertEqual(client[client.index('-verify_hostname') + 1], 'example.com')
        self.assertIn('-sha256', next(call for call in calls if call[0] == 'x509'))

    def test_tls_failure_survives_successful_pipeline_tail(self):
        self.setup_tls()
        self.env['TLS_FAILURE'] = '1'
        self.run_script('inspect-tls.sh', 'example.com', expected=1)

    def setup_wget(self):
        self.fake('wget', '''import json, os, pathlib, signal, sys, time
output = next(arg.split('=', 1)[1] for arg in sys.argv if arg.startswith('--output-document='))
def record(event):
    with open(os.environ['TEST_LOG'], 'a') as log:
        log.write(json.dumps({'event': event, 'pid': os.getpid(), 'output': output, 'args': sys.argv[1:]}) + '\\n')
def stop(signum, frame):
    record('stop')
    sys.exit(143)
signal.signal(signal.SIGTERM, stop)
record('start')
time.sleep(float(os.environ.get('DOWNLOAD_DELAY', '0.08')))
pathlib.Path(output).write_text('fixture')
record('end')
sys.exit(1 if pathlib.Path(output).name == os.environ.get('FAIL_FILE') else 0)
''')

    def test_downloads_bound_concurrency_and_preserve_url(self):
        self.setup_wget()
        url = 'https://example.com/a?x=1&y=2'
        self.run_script('parallel-wget.sh', url, '5', '2', 'output with spaces')
        active, maximum, starts = 0, 0, 0
        for event in self.command_log():
            if event['event'] == 'start':
                active += 1
                starts += 1
                self.assertEqual(event['args'][-1], url)
            else:
                active -= 1
            maximum = max(maximum, active)
        self.assertEqual(starts, 5)
        self.assertEqual(active, 0)
        self.assertLessEqual(maximum, 2)
        self.assertEqual(len(list((self.work / 'output with spaces').glob('*/*.download'))), 5)

    def test_download_failure_and_distinct_run_directories(self):
        self.setup_wget()
        self.env['FAIL_FILE'] = '2.download'
        self.run_script('parallel-wget.sh', 'https://example.com/', '3', '2', expected=1)
        del self.env['FAIL_FILE']
        self.run_script('parallel-wget.sh', 'https://example.com/', '1')
        self.assertEqual(len(list((self.work / 'downloads').iterdir())), 2)

    def test_download_termination_cleans_children(self):
        self.setup_wget()
        self.env['DOWNLOAD_DELAY'] = '10'
        command = [BASH, str(ROOT / 'bash-shell/parallel-wget.sh'), 'https://example.com/', '3', '2']
        process = subprocess.Popen(command, cwd=self.work, env=self.env, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        try:
            deadline = time.monotonic() + 4
            while time.monotonic() < deadline:
                if Path(self.env['TEST_LOG']).exists() and len(self.command_log()) >= 2:
                    break
                time.sleep(0.02)
            process.terminate()
            process.communicate(timeout=4)
            self.assertEqual(process.returncode, 143)
            events = self.command_log()
            self.assertEqual(sum(e['event'] == 'start' for e in events), 2)
            self.assertEqual(sum(e['event'] == 'stop' for e in events), 2)
        finally:
            if process.poll() is None:
                process.kill()
                process.communicate()

    def test_network_scripts_reject_bad_parameters_before_tools(self):
        for name, args in [('inspect-tls.sh', ['example.com', '65536']),
                           ('inspect-tls.sh', ['-connect', '443']),
                           ('parallel-wget.sh', ['https://example.com/', '0']),
                           ('parallel-wget.sh', ['https://example.com/', '1', '17']),
                           ('parallel-wget.sh', ['file:///etc/passwd']),
                           ('parallel-wget.sh', [])]:
            with self.subTest(name=name, args=args):
                self.run_script(name, *args, expected=2)
        self.assertEqual(set(p.name for p in self.work.iterdir()), {'bin'})

    def test_exercise_index_points_to_documentation(self):
        self.assertIn('docs/shell/exercises.md', self.run_script('exercise-index.sh', expected=2).stdout)


if __name__ == '__main__':
    unittest.main()
