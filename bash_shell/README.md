# Bash 实验

[返回首页](../README.md) · [基础笔记](../docs/README.md#shell) · [练习路线](../docs/shell/exercises.md)

脚本使用 Bash，按表中说明单独运行。网络示例必须传入目标；测试流程不会主动连接外部网络。参数错误通常返回 2，运行失败返回非零。

## 基础练习

| 脚本 | 示例 | 行为与依赖 |
| --- | --- | --- |
| [cal_1_100.sh](cal_1_100.sh) | `bash bash_shell/cal_1_100.sh 100` | 循环求和；范围 0–1000000，支持交互输入 |
| [multiplying.sh](multiplying.sh) | `bash bash_shell/multiplying.sh -12 08` | 两整数相乘；每个数最多 9 位，前导零按十进制处理 |
| [cal_pi.sh](cal_pi.sh) | `bash bash_shell/cal_pi.sh 20` | 使用 bc 计算 π；10–10000 位，省略参数时提示输入 |
| [cal_retired.sh](cal_retired.sh) | `bash bash_shell/cal_retired.sh 20300101` | 距目标日期当地午夜的实际时间差；需要 GNU date 或 gdate |
| [create_3_filename.sh](create_3_filename.sh) | `bash bash_shell/create_3_filename.sh './demo-'` | 在当前目录创建带日期的 3 个文件；已有文件更新时间戳，需要 GNU date 或 gdate |
| [file_perm.sh](file_perm.sh) | `bash bash_shell/file_perm.sh 'my file.txt'` | 检查类型及当前用户访问权限，支持空格与符号链接 |
| [date.sh](date.sh) | `bash bash_shell/date.sh 3 1 ./date.log` | 每秒追加时间，共 3 次；默认 5 次，间隔 1 秒 |
| [hello-2.sh](hello-2.sh)、[hello-3.sh](hello-3.sh) | `bash bash_shell/hello-3.sh hello` | 对比 if 与 case 分支 |
| [how_paras.sh](how_paras.sh) | `bash bash_shell/how_paras.sh 'a b' c` | 展示参数边界；至少 2 个参数 |
| [show123-2.sh](show123-2.sh)、[show123-3.sh](show123-3.sh) | `bash bash_shell/show123-3.sh two` | 函数与 case；接受 one/two/three |
| [show_animals.sh](show_animals.sh) | `bash bash_shell/show_animals.sh` | for 循环 |
| [showname.sh](showname.sh) | `bash bash_shell/showname.sh` | 交互式读取姓名；EOF 时退出 |
| [userid.sh](userid.sh) | `bash bash_shell/userid.sh` | 读取本机 /etc/passwd 并调用 id，不遍历外部目录服务 |
| [yes_to_stop.sh](yes_to_stop.sh) | `bash bash_shell/yes_to_stop.sh` | 读到 yes/YES 后结束；EOF 不会死循环 |

## 系统与网络练习

| 脚本 | 示例 | 行为与依赖 |
| --- | --- | --- |
| [netstat.sh](netstat.sh) | `bash bash_shell/netstat.sh` | 使用 ss，缺少时回退 netstat；精确检查 TCP 80/22/25/21 的监听，不创建共享临时文件 |
| [pingip.sh](pingip.sh) | `bash bash_shell/pingip.sh 192.0.2 1 3` | Linux ping；显式指定 /24 前缀，范围 1–254；无回复标为 NO_REPLY，不断言宕机 |
| [multi-process-wget.sh](multi-process-wget.sh) | `bash bash_shell/multi-process-wget.sh https://example.com/ 4 2 ./downloads` | wget；下载次数 1–1000，并发 1–16，每次建独立输出目录，每进程限速 100k；任一失败返回非零 |
| [open_ssl](open_ssl) | `bash bash_shell/open_ssl example.com 443` | OpenSSL 1.1.1+、GNU timeout；15 秒连接时限，校验证书与目标名，输出 SHA-256 指纹；可接受 IPv4 |
| [gen_ifcfg](gen_ifcfg) | `bash bash_shell/gen_ifcfg eth0 02:00:00:00:00:01 192.0.2.10 255.255.255.0` | 仅输出旧式 ifcfg 配置，不写 /etc；检查地址与掩码。适用于学习旧 network-scripts 格式 |

`192.0.2.0/24` 为文档示例网段；运行前替换为自己管理的实验地址。`gen_ifcfg` 不负责启用接口、设置路由或 DNS；现代系统请使用对应网络管理器的配置方式。输出到文件可显式重定向到 `./ifcfg-example`，先阅读再决定如何应用。

## 旧版练习合集

[shell.sh](shell.sh) 原来混合了中文标题与多段不相关代码，无法作为整体执行。现在执行它只显示阅读位置并返回 2；原有练习主题与修正说明整理到 [练习路线](../docs/shell/exercises.md)。

## 验证

在仓库根目录运行 `python3 tools/check.py --shellcheck`。测试覆盖输入校验、文件名空格、EOF、端口误匹配、网络命令参数、下载失败与并发限制。Linux 上会实际运行日期练习；网络、TLS 和下载使用替身命令。
