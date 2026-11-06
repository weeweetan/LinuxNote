# uname

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

查看内核与机器架构。

## 常用示例

```bash
uname -r
uname -m
uname -a
cat /etc/os-release
```

## 使用说明

`-r` 显示内核 release，`-m` 显示机器硬件名；发行版信息从 `/etc/os-release` 获取。发行版版本与内核版本是不同信息。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/uname.1.html)；实际选项以本机安装版本的手册为准。
