# sar

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

采样或回看系统活动。

## 常用示例

```bash
sar -u 1 5
sar -n DEV 1 5
sar -n TCP,ETCP 1 5
sar -B 1 5
sar -f /path/to/sa-file
```

## 使用说明

来自 sysstat。网络设备吞吐用 `-n DEV`，TCP 统计用 `-n TCP,ETCP`；`-B` 表示分页统计，`-n B` 不是网络字节统计选项。

读取历史数据需要事先启用 sysstat 的数据采集，文件路径随发行版配置不同；即时采样不依赖历史文件。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/sar.1.html)；实际选项以本机安装版本的手册为准。
