# find

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

按名称、类型和时间查找文件。

## 常用示例

```bash
find ./logs -type f -name '*.log'
find . -maxdepth 1 -type f -mtime +2 -print
# 检查匹配结果后再删除：
# find . -maxdepth 1 -type f -mtime +2 -delete
```

## 使用说明

普通文件是 `-type f`，目录是 `-type d`，不是 `-type file`。通配符要加引号，交给 find 而不是 shell 展开。

`-mtime` 按经过的 24 小时向下取整；`+2` 表示取整后大于 2，即至少 72 小时。删除示例限制当前层普通文件，并先预览。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/find.1.html)；实际选项以本机安装版本的手册为准。
