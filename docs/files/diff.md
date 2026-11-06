# diff

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

比较两个文本文件或目录。

## 常用示例

```bash
diff -u old.conf new.conf
diff -ru old-dir new-dir
```

## 使用说明

`-u` 输出统一格式的差异，`-r` 递归比较目录。退出码 0 表示一致、1 表示有差异、大于 1 表示出错；有差异并不等同于工具执行失败。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/diff.1.html)；实际选项以本机安装版本的手册为准。
