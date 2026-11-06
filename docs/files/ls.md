# ls

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

查看文件属性和修改时间。

## 常用示例

```bash
ls -lah
ls -lat
ls -l --full-time
```

## 使用说明

`-l` 显示详细属性，`-a` 包含隐藏文件，`-t` 按修改时间从新到旧排序，`-h` 提供易读大小。`--full-time` 是 GNU 选项。脚本遍历文件应使用 glob 或 `find`，不要解析 `ls` 的列。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/ls.1.html)；实际选项以本机安装版本的手册为准。
