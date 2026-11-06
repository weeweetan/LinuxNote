# iotop

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

按进程观察磁盘 I/O 活动。

## 常用示例

```bash
sudo iotop -oP
sudo iotop -b -o -d 1 -n 5
```

## 使用说明

`-P` 按进程显示，`-o` 只看有 I/O 的任务，`-b` 批处理，`-d` 指定间隔，`-a` 累计模式。iotop 存在不同实现，选项与所需内核记账功能以本机 `iotop --help` 为准。

## 参考

[命令手册](https://github.com/Tomas-M/iotop)；实际选项以本机安装版本的手册为准。
