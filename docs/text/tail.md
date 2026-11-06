# tail

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

查看文件末尾并持续跟踪日志。

## 常用示例

```bash
tail -n 50 app.log
tail -f app.log
tail -F app.log
```

## 使用说明

`-f` 持续跟踪文件增长，默认跟踪文件描述符；GNU `-F` 相当于 `--follow=name --retry`，更适合按文件名轮转的日志。使用 Ctrl-C 停止跟踪。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/tail.1.html)；实际选项以本机安装版本的手册为准。
