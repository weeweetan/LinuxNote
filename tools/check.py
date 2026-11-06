#!/usr/bin/env python3
"""Offline checks for the Markdown and Bash conventions used in this repository."""
import argparse
import re
import shutil
import subprocess
import sys
from collections import Counter
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
LINK = re.compile(r'!?\[[^\]\n]+\]\(<?([^\s>]+?)>?(?:\s+"[^"]*")?\)')


def prose(text):
    """Exclude fenced and inline code; return prose and an unclosed-fence flag."""
    lines, fence = [], None
    for line in text.splitlines():
        match = re.match(r'^\s{0,3}(`{3,}|~{3,})(.*)$', line)
        if match:
            marker, rest = match.groups()
            if fence is None:
                fence = marker
            elif marker[0] == fence[0] and len(marker) >= len(fence) and not rest.strip():
                fence = None
            continue
        if fence is None:
            # Keep inline-code text for heading slugs, but hide Markdown-looking links in it.
            lines.append(re.sub(r'(`+)(.*?)\1', lambda m: m[2].replace('[', '').replace(']', ''), line))
    return '\n'.join(lines), fence is not None


def anchors(text):
    content, _ = prose(text)
    result = set(re.findall(r'<a\s+id="([^"]+)"', content))
    counts = Counter()
    for heading in re.findall(r'^#{1,6}\s+(.+?)\s*#*$', content, re.MULTILINE):
        heading = re.sub(r'\[([^\]]+)\]\([^)]*\)', r'\1', heading)
        slug = re.sub(r'[^\w\- ]', '', heading.lower()).replace(' ', '-')
        suffix = f'-{counts[slug]}' if counts[slug] else ''
        result.add(slug + suffix)
        counts[slug] += 1
    return result


def check_markdown(paths, root):
    errors = []
    anchor_cache = {}
    for path in paths:
        text = path.read_text(encoding='utf-8')
        label = path.relative_to(root)
        if not text.startswith('# ') or not text.endswith('\n'):
            errors.append(f'{label}: expected a title and final newline')
        content, unclosed = prose(text)
        if unclosed:
            errors.append(f'{label}: unclosed code fence')
        for href in LINK.findall(content):
            url = urlsplit(href)
            if url.scheme or url.netloc:
                continue
            target = (path.parent / unquote(url.path)).resolve() if url.path else path
            if not target.is_relative_to(root) or not target.exists():
                errors.append(f'{label}: missing or out-of-repository link {href}')
                continue
            if url.fragment:
                if not target.is_file() or target.suffix != '.md':
                    errors.append(f'{label}: cannot resolve document anchor {href}')
                    continue
                if target not in anchor_cache:
                    anchor_cache[target] = anchors(target.read_text(encoding='utf-8'))
                if unquote(url.fragment) not in anchor_cache[target]:
                    errors.append(f'{label}: missing anchor {href}')
    return errors


def check_filenames():
    paths = subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode('utf-8').split('\0')
    errors = []
    special = {'README.md', 'CONTRIBUTING.md', '.gitignore', '.editorconfig', '.github'}
    for name in filter(None, paths):
        path = Path(name)
        if path.parts[0] == 'bash-shell' and path.name != 'README.md' and path.suffix != '.sh':
            errors.append(f'{name}: Bash scripts must use the .sh extension')
        for directory in path.parts[:-1]:
            if directory != '.github' and not re.fullmatch(r'[a-z0-9]+(?:-[a-z0-9]+)*', directory):
                errors.append(f'{name}: directory names must use lowercase letters and hyphens')
        if path.name in special:
            continue
        stem = r'[a-z][a-z0-9]*(?:_[a-z0-9]+)*' if path.suffix == '.py' else r'[a-z0-9]+(?:-[a-z0-9]+)*'
        if not path.suffix or not re.fullmatch(stem + r'\.[a-z0-9]+', path.name):
            errors.append(f'{name}: use a lowercase name and a file extension; Python uses underscores')
    return errors, len(list(filter(None, paths)))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--shellcheck', action='store_true', help='Require ShellCheck as well')
    args = parser.parse_args()
    filename_errors, file_count = check_filenames()
    if filename_errors:
        parser.exit(1, '\n'.join(filename_errors) + '\n')
    print(f'Checked naming conventions for {file_count} tracked files.', flush=True)
    subprocess.run([sys.executable, str(ROOT / 'tools/build_index.py'), '--check'], check=True)
    paths = [ROOT / 'README.md', ROOT / 'CONTRIBUTING.md', ROOT / 'bash-shell/README.md']
    paths.extend(sorted((ROOT / 'docs').rglob('*.md')))
    errors = check_markdown(paths, ROOT)
    if errors:
        parser.exit(1, '\n'.join(errors) + '\n')
    print(f'Checked {len(paths)} Markdown documents and their internal links.', flush=True)
    scripts = sorted(p for p in (ROOT / 'bash-shell').iterdir() if p.is_file() and p.suffix != '.md')
    for script in scripts:
        if not script.read_text(encoding='utf-8').startswith('#!/usr/bin/env bash\n'):
            parser.exit(1, f'Missing Bash shebang: {script.name}\n')
        subprocess.run(['bash', '-n', str(script)], check=True)
    print(f'Checked Bash syntax for {len(scripts)} scripts.', flush=True)
    shellcheck = shutil.which('shellcheck')
    if args.shellcheck and not shellcheck:
        parser.exit(1, 'ShellCheck is required; install it and retry.\n')
    if shellcheck:
        subprocess.run([shellcheck, '--severity=style', *map(str, scripts)], check=True)
    else:
        print('ShellCheck not installed; CI requires it with --shellcheck.', flush=True)
    subprocess.run([sys.executable, '-m', 'unittest', 'discover', '-s', 'tests', '-v'], cwd=ROOT, check=True)


if __name__ == '__main__':
    main()
