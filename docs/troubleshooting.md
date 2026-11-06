# 按现象排查

[返回首页](../README.md) · [命令目录](README.md)

先记录异常发生时间、影响范围、目标 PID 和变化前后的指标，再逐步缩小范围。以下命令是观察入口，单个指标不能独立证明根因。

## CPU 高或系统响应慢

| 顺序 | 观察 | 接下来确认什么 |
| --- | --- | --- |
| 1 | [uptime](performance/uptime.md)、[vmstat 1 5](performance/vmstat.md) | 可运行队列、阻塞任务、CPU 时间分布 |
| 2 | [mpstat -P ALL 1 5](performance/mpstat.md) | 是整机忙，还是某个 CPU 热点 |
| 3 | [pidstat -p PID 1 5](performance/pidstat.md) | 哪个进程在采样窗口内消耗 CPU |
| 4 | [perf](performance/perf.md) | 在权限与开销允许时，采样具体函数及调用栈 |

负载高也可能与不可中断等待有关；看到 `wa` 高还需关联块设备和应用延迟，不要直接归因于某个进程。

## 内存紧张

1. [free -h](performance/free.md)：观察 available 与 swap，区别缓存和真正的内存压力。
2. [vmstat 1 5](performance/vmstat.md)：查看是否持续发生换入、换出。
3. [pidstat -r](performance/pidstat.md)、[pmap](performance/pmap.md)：定位进程及其映射。
4. [smem](performance/smem.md)：用 PSS/USS 区分共享页与独占页，避免简单相加 RSS。

判断泄漏需要时间序列及业务负载对比，一次快照不足以确认。

## 磁盘或日志变慢

1. [iostat -xz 1 5](performance/iostat.md)：关联吞吐、队列与延迟。
2. [pidstat -d](performance/pidstat.md)、[iotop](performance/iotop.md)：定位有 I/O 活动的进程。
3. [tail -F](text/tail.md)、[grep](text/grep.md)：核对同一时间的应用日志。

磁盘空间不足可以先执行 `df -h` 与 `df -i`，分别查看容量和 inode。清理前用 [find](files/find.md) 预览目标；不要用截断正在写入的文件代替日志轮转。

## 连接失败或带宽异常

1. [ip](network/ip.md)：核对地址、接口与路由选择。
2. [ss](network/ss.md)：确认精确端口是否监听、连接处于什么状态。
3. [systemctl](services/systemctl.md)：确认服务状态，并检查对应时间的日志。
4. [iftop](network/iftop.md) / [NetHogs](network/nethogs.md)：区分连接维度与进程维度的流量。
5. [tcpdump](network/tcpdump.md) → [tshark](network/tshark.md)：限制过滤范围和包数后抓包，再离线分析。

没有 ICMP 回复不等于主机宕机；TCP 端口监听也不等于应用健康。继续检查实际协议的响应和日志。

## 定时任务没有运行

查看 [crontab](services/cron.md) 的时间字段、用户身份、绝对路径、PATH 与输出重定向。交互式终端中能运行，不代表在 cron 的环境下也能运行。

## 进一步阅读

[vmstat 手册](https://man7.org/linux/man-pages/man8/vmstat.8.html)、[proc 文件系统手册](https://man7.org/linux/man-pages/man5/proc.5.html)与各篇笔记中的工具手册。
