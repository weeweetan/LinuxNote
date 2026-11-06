# uptime

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

查看运行时间和 1、5、15 分钟负载。

## 常用示例

```bash
uptime
nproc
```

## 使用说明

load average 统计可运行与不可中断睡眠任务的负载，不是 CPU 使用率。结合可用 CPU 数、`vmstat` 的 `r/b` 和 CPU 指标判断，不能仅凭负载高就认定 CPU 瓶颈。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/uptime.1.html)；实际选项以本机安装版本的手册为准。
