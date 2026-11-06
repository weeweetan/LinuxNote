# netstat

[返回分类目录](../README.md#network) · [排障路线](../troubleshooting.md)

读取旧环境的连接与协议统计。

## 常用示例

```bash
netstat -lntp
netstat -anp
netstat -s
```

## 使用说明

`-a` 显示所有 socket，`-s` 才是协议统计。netstat 通常来自 net-tools；新环境可优先使用 `ss`，路由与接口信息可使用 `ip`。

## 参考

[命令手册](https://man7.org/linux/man-pages/man8/netstat.8.html)；实际选项以本机安装版本的手册为准。
