# ss

[返回分类目录](../README.md#network) · [排障路线](../troubleshooting.md)

查看监听端口和已建立连接。

## 常用示例

```bash
ss -lntp
ss -lnup
ss -s
ss -lnt 'sport = :80'
ss -ant state established
```

## 使用说明

`-n` 不解析名称，`-t/-u` 选择 TCP/UDP，`-l` 只看监听，`-a` 包含非监听 socket，`-p` 显示进程。查看其他用户的进程可能需要权限。

用端口过滤表达式可避免文本搜索 `:80` 同时命中 `:8080`。

## 参考

[命令手册](https://man7.org/linux/man-pages/man8/ss.8.html)；实际选项以本机安装版本的手册为准。
