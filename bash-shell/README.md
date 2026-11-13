# Bash 实验

[返回首页](../README.md) · [基础笔记](../docs/README.md#shell) · [练习路线](../docs/shell/exercises.md)

脚本使用 Bash，按表中说明单独运行。网络示例必须传入目标；测试流程不会主动连接外部网络。参数错误通常返回 2，运行失败返回非零。

## 基础练习

| 脚本 | 示例 | 行为与依赖 |
| --- | --- | --- |
| [sum-range.sh](sum-range.sh) | `bash bash-shell/sum-range.sh 100` | 循环求和；范围 0–1000000，支持交互输入 |
| [multiply-integers.sh](multiply-integers.sh) | `bash bash-shell/multiply-integers.sh -12 08` | 两整数相乘；每个数最多 9 位，前导零按十进制处理 |
| [calculate-pi.sh](calculate-pi.sh) | `bash bash-shell/calculate-pi.sh 20` | 使用 bc 计算 π；10–10000 位，省略参数时提示输入 |
| [date-countdown.sh](date-countdown.sh) | `bash bash-shell/date-countdown.sh 20300101` | 距目标日期当地午夜的实际时间差；需要 GNU date 或 gdate |
| [create-dated-files.sh](create-dated-files.sh) | `bash bash-shell/create-dated-files.sh './demo-'` | 在当前目录创建带日期的 3 个文件；已有文件更新时间戳，需要 GNU date 或 gdate |
| [check-file-permissions.sh](check-file-permissions.sh) | `bash bash-shell/check-file-permissions.sh 'my file.txt'` | 检查类型及当前用户访问权限，支持空格与符号链接 |
| [log-timestamps.sh](log-timestamps.sh) | `bash bash-shell/log-timestamps.sh 3 1 ./date.log` | 每秒追加时间，共 3 次；默认 5 次，间隔 1 秒 |
| [hello-if.sh](hello-if.sh)、[hello-case.sh](hello-case.sh) | `bash bash-shell/hello-case.sh hello` | 对比 if 与 case 分支 |
| [show-arguments.sh](show-arguments.sh) | `bash bash-shell/show-arguments.sh 'a b' c` | 展示参数边界；至少 2 个参数 |
| [choice-uppercase.sh](choice-uppercase.sh)、[choice-number.sh](choice-number.sh) | `bash bash-shell/choice-number.sh two` | 函数与 case；接受 one/two/three |
| [list-animals.sh](list-animals.sh) | `bash bash-shell/list-animals.sh` | for 循环 |
| [read-full-name.sh](read-full-name.sh) | `bash bash-shell/read-full-name.sh` | 交互式读取姓名；EOF 时退出 |
| [list-user-ids.sh](list-user-ids.sh) | `bash bash-shell/list-user-ids.sh` | 读取本机 /etc/passwd 并调用 id，不遍历外部目录服务 |
| [wait-for-yes.sh](wait-for-yes.sh) | `bash bash-shell/wait-for-yes.sh` | 读到 yes/YES 后结束；EOF 不会死循环 |

## 系统与网络练习

| 脚本 | 示例 | 行为与依赖 |
| --- | --- | --- |
| [check-listening-ports.sh](check-listening-ports.sh) | `bash bash-shell/check-listening-ports.sh` | 使用 ss，缺少时回退 netstat；精确检查 TCP 80/22/25/21 的监听，不创建共享临时文件 |
| [ping-range.sh](ping-range.sh) | `bash bash-shell/ping-range.sh 192.0.2 1 3` | Linux ping；显式指定 /24 前缀，范围 1–254；无回复标为 NO_REPLY，不断言宕机 |
| [parallel-wget.sh](parallel-wget.sh) | `bash bash-shell/parallel-wget.sh https://example.com/ 4 2 ./downloads` | wget；下载次数 1–1000，并发 1–16，每次建独立输出目录，每进程限速 100k；任一失败返回非零 |
| [inspect-tls.sh](inspect-tls.sh) | `bash bash-shell/inspect-tls.sh example.com 443` | OpenSSL 1.1.1+、GNU timeout、cat；15 秒连接时限，校验证书与目标名，输出 SHA-256 指纹；可接受 IPv4 |
| [generate-ifcfg.sh](generate-ifcfg.sh) | `bash bash-shell/generate-ifcfg.sh eth0 02:00:00:00:00:01 192.0.2.10 255.255.255.0` | 仅输出旧式 ifcfg 配置，不写 /etc；检查地址与掩码。适用于学习旧 network-scripts 格式 |

`192.0.2.0/24` 为文档示例网段；运行前替换为自己管理的实验地址。`generate-ifcfg.sh` 不负责启用接口、设置路由或 DNS；现代系统请使用对应网络管理器的配置方式。输出到文件可显式重定向到 `./ifcfg-example`，先阅读再决定如何应用。

## TLS 输出与管道状态

`inspect-tls.sh` 使用 `openssl x509` 展示首个证书的信息，随后用 `cat` 读取并丢弃剩余输出。这样在证书解析器提前退出、上游仍有大量输出时，不会因管道关闭而把正常的连接误报为失败；不缓存完整输出或创建临时证书文件。展示参数见 [OpenSSL x509 文档](https://docs.openssl.org/3.5/man1/openssl-x509/)。

脚本继续启用 `pipefail`，并保留证书解析或剩余输出读取的失败状态。即使 stdout 已打印指纹，上游验证失败仍会返回非零，不能仅凭指纹输出判断检查成功。退出状态的组合规则见 [Bash Pipelines](https://www.gnu.org/software/bash/manual/html_node/Pipelines.html)。

## 练习合集入口

[练习路线](../docs/shell/exercises.md) 按输入、文件、网络与进程组织练习主题。[exercise-index.sh](exercise-index.sh) 可在终端显示该文档的位置，并返回 2，提示选择具体练习。

## 验证

在仓库根目录运行 `python3 tools/check.py --shellcheck`。测试覆盖输入校验、文件名空格、EOF、端口误匹配、网络命令参数、下载失败与并发限制，以及 TLS 解析器提前退出后的大输出读取与各阶段失败。Linux 上会实际运行日期练习；网络、TLS 和下载使用替身命令。
