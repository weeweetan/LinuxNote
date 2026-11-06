import importlib.util
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('repo_check', ROOT / 'tools/check.py')
checks = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checks)


class MarkdownTests(unittest.TestCase):
    def test_local_links_encoded_paths_anchors_and_code_examples(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory).resolve()
            target = root / '中文 note.md'
            target.write_text('# 标题\n\n<a id="custom"></a>\n\n## 同名\n\n## 同名\n')
            page = root / 'README.md'
            page.write_text('# Home\n\n[有效](中文%20note.md#同名-1)\n\n[显式](中文%20note.md#custom)\n'
                            '\n[外链](https://example.com/absent)\n\n`[示意](absent.md)`\n'
                            '\n```bash\n[示意](absent.md)\n```\n')
            self.assertEqual(checks.check_markdown([page, target], root), [])

    def test_missing_file_anchor_and_unclosed_fence_are_errors(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory).resolve()
            page = root / 'README.md'
            page.write_text('# Home\n\n[文件](absent.md)\n\n[锚点](#absent)\n\n```bash\n')
            errors = checks.check_markdown([page], root)
            self.assertEqual(len(errors), 3, errors)


if __name__ == '__main__':
    unittest.main()
