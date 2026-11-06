# iptables

[返回分类目录](../README.md#network) · [排障路线](../troubleshooting.md)

查看规则顺序、计数器和 NAT 表。

## 常用示例

```bash
sudo iptables -S
sudo iptables -L -n -v --line-numbers
sudo iptables -t nat -S
```

## 使用说明

`-A` 追加规则，`-D` 删除规则，目标写作大写 `DROP`。INPUT 处理送往本机的报文，OUTPUT 处理本机生成的报文，转发报文走 FORWARD。

修改规则可能中断 SSH。先识别系统使用 iptables-nft、iptables-legacy、nftables 还是上层管理器，不混用未经核对的规则操作。

## 参考

[命令手册](https://man7.org/linux/man-pages/man8/iptables.8.html)；实际选项以本机安装版本的手册为准。
