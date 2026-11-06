# free

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

观察物理内存、缓存和交换空间。

## 常用示例

```bash
free -h
free -m
free -g
```

## 使用说明

关注 `available`，它估计无需交换即可启动新应用的内存；`free` 仅表示完全空闲部分。缓存占用并不自动意味着内存泄漏。`-m/-g` 分别以 MiB/GiB 显示，`-h` 自动选择单位。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/free.1.html)；实际选项以本机安装版本的手册为准。
