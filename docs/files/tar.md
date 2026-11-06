# tar

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

创建、列出和解开归档。

## 常用示例

```bash
tar -czf archive.tar.gz ./data
tar -tzf archive.tar.gz
mkdir -p ./unpack
tar -xzf archive.tar.gz -C ./unpack
```

## 使用说明

`-c` 创建，`-x` 解开，`-t` 列出内容，`-z` 使用 gzip，`-v` 显示处理过程；`-f` 指定归档文件名，不是显示文件。解开归档前可先查看内容，并使用独立目录。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/tar.1.html)；实际选项以本机安装版本的手册为准。
