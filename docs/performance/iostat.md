# iostat

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

查看块设备吞吐、延迟与利用率。

## 常用示例

```bash
iostat -xz 1 5
iostat -xmy 1 5
```

## 使用说明

工具来自 sysstat。`-x` 为扩展统计，`-m` 使用 MiB/s，`-z` 隐藏无活动设备，`-y` 在重复采样时跳过开机以来首份统计。

结合 `await`、队列长度、吞吐量和应用延迟判断；对并行设备、RAID 和 SSD，`%util` 接近 100% 不能单独证明达到性能上限。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/iostat.1.html)；实际选项以本机安装版本的手册为准。
