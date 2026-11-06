# wc

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

统计行数、单词数和字节数。

## 常用示例

```bash
wc -l access.log
wc -w article.txt
wc -c data.bin
wc -m article.txt
```

## 使用说明

`-l` 统计换行符，末尾没有换行的最后一行不会计入。`-c` 是字节数，`-m` 是字符数，后者受 locale 的字符编码影响。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/wc.1.html)；实际选项以本机安装版本的手册为准。
