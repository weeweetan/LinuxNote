# ps

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

查看进程快照及启动时间。

## 常用示例

```bash
ps -eo pid,ppid,user,comm,lstart,etime
ps -eo pid,comm,%cpu,%mem --sort=-%cpu
ps -p 1234 -o pid,ppid,lstart,etime,args
```

## 使用说明

将 `1234` 替换为目标 PID。`lstart` 是启动时间，`etime` 是已运行时间。`ps` 是快照，`%CPU` 通常反映进程存活期间的平均值；看采样窗口内的消耗可用 `pidstat`。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/ps.1.html)；实际选项以本机安装版本的手册为准。
