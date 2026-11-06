# pmap

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

查看进程的内存映射及驻留内存。

## 常用示例

```bash
pmap 1234
pmap -x 1234
pmap -X 1234
```

## 使用说明

将 `1234` 替换为目标 PID；访问其他用户的进程可能受权限限制。`-x` 显示扩展信息，`-X` 字段取决于内核导出的 smaps。虚拟映射大小不等于实际物理内存使用；RSS 中的共享页也不能跨进程直接求和。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/pmap.1.html)；实际选项以本机安装版本的手册为准。
