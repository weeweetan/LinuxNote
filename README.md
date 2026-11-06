# LinuxNote

**从一条命令，到一条排障思路。**

Linux 命令速查、性能分析与 Bash 练习。按使用场景查找命令，也可以沿着学习路线逐步练习。

[全部笔记](docs/README.md) · [排障路线](docs/troubleshooting.md) · [Shell 实验](bash_shell/README.md) · [维护指南](CONTRIBUTING.md)

```text
观察现象 → 缩小范围 → 找到进程 / 连接 / 文件 → 验证判断
```

## 从哪里开始

| 我想做什么 | 从这里进入 |
| --- | --- |
| 处理日志、筛选 JSON、统计字段 | [文本处理](docs/README.md#text) |
| 查找文件、打包、同步、比较差异 | [文件与目录](docs/README.md#files) |
| 排查 CPU、内存或磁盘 I/O | [进程与性能](docs/README.md#performance) |
| 查端口、路由、带宽、抓包 | [网络与抓包](docs/README.md#network) |
| 看服务状态、定时任务和历史活动 | [服务与任务](docs/README.md#services) |
| 找动态库、反汇编、定位源码行 | [二进制与调试](docs/README.md#debugging) |
| 学引用、循环、数组与脚本参数 | [Bash 基础](docs/README.md#shell) |

## 三条学习路线

1. **命令入门**：[ls](docs/files/ls.md) → [find](docs/files/find.md) → [grep](docs/text/grep.md) → [awk](docs/text/awk.md) → [jq](docs/text/jq.md)。
2. **系统排障**：[uptime](docs/performance/uptime.md) → [vmstat](docs/performance/vmstat.md) → [pidstat](docs/performance/pidstat.md) → [iostat](docs/performance/iostat.md) → [ss](docs/network/ss.md)。
3. **脚本实践**：[引用与转义](docs/shell/quoting.md) → [IFS / read](docs/shell/ifs.md) → [for](docs/shell/for.md) → [练习索引](docs/shell/exercises.md)。

## 本地使用

```bash
git clone https://github.com/weeweetan/LinuxNote.git
cd LinuxNote

# 纯 Markdown 笔记，直接用编辑器或 GitHub 阅读
bash bash_shell/cal_1_100.sh 100
bash bash_shell/file_perm.sh README.md

# 检查文档、脚本语法和回归用例，需要 Python 3.10+ 与 Bash
python3 tools/check.py
```

笔记以 **Linux、GNU 工具及 Bash** 为主要环境。macOS 的 BSD 工具和内置 Bash 版本有差异；涉及 GNU date、Linux ping、ss、systemd 的示例请在 Linux 上运行，具体依赖见 [脚本说明](bash_shell/README.md)。阅读与编辑不需要安装任何构建工具。

## 仓库地图

```text
docs/               分类笔记、排障路线与学习索引
  catalog.json      笔记元数据；用于生成目录和旧路径说明
bash_shell/         独立 Bash 练习与使用说明
tools/              文档索引生成、链接与脚本检查
tests/              输入边界、端口识别和下载并发等回归测试
.github/workflows/  Linux 上的自动检查
```

根目录原有的无扩展名笔记保留为迁移说明，旧书签仍能找到新位置。重复的 `pmap` 条目已合并。旧版 `bash_shell/shell.sh` 原本是文字与代码的混合集合，现在由 [练习索引](docs/shell/exercises.md) 承接，执行旧入口只会显示阅读位置。

## 继续完善

新增笔记使用 [模板](docs/TEMPLATE.md)，登记到 `docs/catalog.json` 后执行 `python3 tools/build_index.py`。提交前运行 `python3 tools/check.py --shellcheck`；详细流程见 [维护指南](CONTRIBUTING.md)。
