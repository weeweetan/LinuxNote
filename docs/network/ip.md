# ip

[返回分类目录](../README.md#network) · [排障路线](../troubleshooting.md)

查看地址、链路和路由。

## 常用示例

```bash
ip -br addr
ip -s link
ip route show
ip route get 192.0.2.1
```

## 使用说明

来自 iproute2。`ip route get` 查询内核对目标的路由选择，不代表发起连接；`192.0.2.1` 为文档示例地址。变更地址、链路状态和路由会影响连通性，本页示例均为查询。

## 参考

[命令手册](https://man7.org/linux/man-pages/man8/ip.8.html)；实际选项以本机安装版本的手册为准。
