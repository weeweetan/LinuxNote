# iftop

[返回分类目录](../README.md#network) · [排障路线](../troubleshooting.md)

按连接观察网卡带宽。

## 常用示例

```bash
sudo iftop -n -P -i eth0
```

## 使用说明

将 `eth0` 替换为实际接口，可先用 `ip -br link` 查询。`-n` 禁用主机名解析，`-P` 显示端口；它按主机连接统计流量，不等同于按进程统计。

## 参考

[命令手册](https://www.ex-parrot.com/pdw/iftop/)；实际选项以本机安装版本的手册为准。
