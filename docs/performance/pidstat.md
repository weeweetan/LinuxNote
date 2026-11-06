# pidstat

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

持续采样指定进程的 CPU、内存和 I/O。

## 常用示例

```bash
pidstat -p 1234 1 5
pidstat -r -p 1234 1 5
pidstat -d -p 1234 1 5
pidstat -t -p 1234 1 5
```

## 使用说明

来自 sysstat。`-p` 选择 PID，`-r` 显示内存与缺页，`-d` 显示 I/O，`-t` 展示线程。进程退出后 PID 可能复用，长时间排查需核对进程身份。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/pidstat.1.html)；实际选项以本机安装版本的手册为准。
