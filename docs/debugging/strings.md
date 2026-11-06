# strings

[返回分类目录](../README.md#debugging) · [排障路线](../troubleshooting.md)

从二进制中提取可打印字符串。

## 常用示例

```bash
strings -a ./program
strings -a -n 8 ./program
strings -a -t x ./program
```

## 使用说明

`-a` 扫描整个文件，`-n` 设置最小长度，`-t x` 显示十六进制文件偏移。提取出的文本不代表可执行逻辑、使用中的配置或可信的版本信息。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/strings.1.html)；实际选项以本机安装版本的手册为准。
