# Shell 练习路线

[返回首页](../../README.md) · [脚本与依赖](../../bash-shell/README.md) · [Bash 基础](../README.md#shell)

按知识点选择练习主题，配合独立脚本理解输入、判断、文件处理与网络观察。文中的代码片段需准备相应输入。

## 输入、判断与循环

| 练习主题 | 练习入口 | 需要掌握的点 |
| --- | --- | --- |
| 模拟登录、字符串判断、yes/no | [hello-if.sh](../../bash-shell/hello-if.sh)、[wait-for-yes.sh](../../bash-shell/wait-for-yes.sh) | 字符串比较、case、EOF；演示不保存密码或冒充认证系统 |
| 数字比较与计算 | [multiply-integers.sh](../../bash-shell/multiply-integers.sh)、[sum-range.sh](../../bash-shell/sum-range.sh) | 先验证整数，再做算术；前导零、负数与上限 |
| 文件是否存在、文件类型 | [check-file-permissions.sh](../../bash-shell/check-file-permissions.sh) | 使用 `[[ -e "$path" ]]`，保留路径中的空格 |
| for、函数、参数与 case | [for](for.md)、[show-arguments.sh](../../bash-shell/show-arguments.sh)、[choice-number.sh](../../bash-shell/choice-number.sh) | `"$@"` 保留参数边界，函数接收独立参数 |
| 逐行读取、读取文件并计算 | [IFS / read](ifs.md)、[awk](../text/awk.md) | 保留空白、反斜杠及无末尾换行的最后一行 |
| 日期、用户名、系统信息 | [log-timestamps.sh](../../bash-shell/log-timestamps.sh)、[uname](../performance/uname.md) | 有限采样；当前用户使用 `id -un`，不要解析 ps 输出 |

## 文件处理练习

准备一个专用 `./lab` 目录，再尝试查找与筛选：

```bash
mkdir -p ./lab
touch './lab/empty file.txt'
printf '%s\n' 'hello' > ./lab/content.txt

# 预览空文件；不直接执行删除
find ./lab -maxdepth 1 -type f -empty -print

# GNU find：按字节数列出文件后排序
find ./lab -type f -printf '%s %p\n' | sort -nr | head -n 5
```

文件名含换行时，上面的按行展示不适合程序解析。自动处理文件名可使用 [find + xargs 的 NUL 分隔](../files/xargs.md)。复制归档先看 [tar](../files/tar.md) 与 [rsync](../files/rsync.md)，避免通过 `ls -l` 的显示列判断大小。

原草稿中的 `chfs` 属于 AIX 管理命令，不应作为 Linux 文件系统扩容示例；实际扩容步骤取决于文件系统、卷管理与挂载方式。

## 网络与进程练习

- 获取地址：[ip](../network/ip.md)，不依赖旧版 ifconfig 的文本格式。
- 探测显式地址范围：[ping-range.sh](../../bash-shell/ping-range.sh)。ICMP 无回复与主机宕机不是同一结论。
- 判断监听端口：[check-listening-ports.sh](../../bash-shell/check-listening-ports.sh)、[ss](../network/ss.md)。端口 80 不应误命中 8080；需要等待启动时，应设置截止时间。
- 确认进程身份：[ps](../performance/ps.md)、[pstree](../performance/pstree.md)。停止服务优先使用服务管理器；不要从宽泛的 grep 结果直接批量 `kill -9`。

## 账号状态辨析

原草稿将 `/etc/shadow` 中的 `!!` 当成“无密码用户”，这一判断不正确：以 `!` 开头的口令字段表示口令被锁定；空口令字段是另一种状态，还要结合认证配置判断。不要通过输出整份 shadow 文件做练习。

参考：[shadow 手册](https://man7.org/linux/man-pages/man5/shadow.5.html)、[Bash 引用](https://www.gnu.org/software/bash/manual/html_node/Quoting.html)。
