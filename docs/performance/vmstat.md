# vmstat

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

关联运行队列、内存、交换、I/O 与 CPU。

## 常用示例

```bash
vmstat 1 5
vmstat -w 1 5
vmstat -s
```

## 使用说明

刷新间隔是位置参数：`vmstat 1 5` 每秒一次，共输出 5 次；`-m` 显示 slab 信息，不能用来指定间隔。

首行的速率统计通常为开机以来平均，后续是采样间隔统计。`r` 为可运行任务，`b` 为阻塞任务；持续的 `si/so` 可提示交换活动，但仍需结合应用延迟判断。

## 参考

[命令手册](https://man7.org/linux/man-pages/man8/vmstat.8.html)；实际选项以本机安装版本的手册为准。
