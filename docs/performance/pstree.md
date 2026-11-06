# pstree

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

查看进程父子关系与线程。

## 常用示例

```bash
pstree -p
pstree -ap 1234
pstree -sp 1234
```

## 使用说明

`-p` 显示 PID，`-a` 显示命令行参数，`-s` 显示指定进程的父链。命令行可能带凭据，分享输出前检查内容。工具通常来自 psmisc 软件包。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/pstree.1.html)；实际选项以本机安装版本的手册为准。
