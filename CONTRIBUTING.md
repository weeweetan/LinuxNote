# 维护指南

[返回首页](README.md)

## 编辑与同步

```bash
git pull --ff-only
# 使用编辑器修改 docs/ 下的 Markdown 或 bash-shell/ 下的脚本
python3 tools/build_index.py
python3 tools/check.py --shellcheck
```

运行检查需要 Python 3.10+、Bash 和 ShellCheck。Ubuntu/Debian 可通过 `sudo apt-get install python3 shellcheck` 安装检查工具；脚本的额外运行依赖见 [脚本说明](bash-shell/README.md)。

`python3 tools/check.py` 不强制安装 ShellCheck，仍检查文件命名、目录同步、内部链接和锚点、代码围栏、脚本语法与回归用例。CI 使用 `--shellcheck`，缺少工具会直接失败。测试用临时目录与替身命令，不会扫描网络或修改系统配置；Linux 上还会运行 GNU date 的真实用例。

## 文件命名

- 目录名使用小写英文和连字符，如 `bash-shell/`。
- 笔记以 `.md` 结尾，多词用连字符连接，如 `docs/shell/exercises.md`。
- Shell 脚本以 `.sh` 结尾，用名称描述用途，如 `sum-range.sh`、`inspect-tls.sh`。
- Python 文件按模块约定使用小写字母和下划线，如 `build_index.py`、`test_scripts.py`。
- `README.md`、`CONTRIBUTING.md` 及 `.gitignore`、`.editorconfig`、`.github` 等工具约定名称保留。

命令笔记在 `docs/` 中维护，分类元数据只登记当前路径。重命名文件时同步更新链接、命令示例和测试中的调用路径。

## 新增笔记

1. 复制 [模板](docs/template.md) 到对应分类，使用稳定的英文文件名。
2. 写明用途、完整命令、关键参数与输出解读，附上官方手册。
3. 在 [catalog.json](docs/catalog.json) 对应分类的 `items` 中登记 `name`、`path` 和 `summary`。
4. 执行 `python3 tools/build_index.py` 更新目录；`--check` 只校验生成结果是否最新。

不要手工修改生成的 `docs/README.md`。已有路径变更时更新 `catalog.json`。仓库内部链接使用相对路径；引用章节时使用 GitHub 标题锚点或显式 HTML `id`。

## 脚本约定

- 教学脚本尽量独立，明确参数、依赖与输出，不依赖作者的内网地址或临时文件。
- 使用 `read -r`，引用变量；算术运算前校验输入范围，避免溢出与算术表达式注入。
- 参数错误返回 2，运行失败返回非零；有限循环处理 EOF，不对输入结束无限重试。
- 涉及网络的脚本需要显式目标，文件写入限定在调用者选择的位置。
- 新增实际行为时补充有意义的回归用例，不通过执行线上命令验证。

## 自动检查

[Checks 工作流](.github/workflows/check.yml) 在 push 与 pull request 上运行。它验证仓库内部结构与脚本行为，不验证所有外部网站是否在线，也不把命令手册中的所有示例作为程序执行。
