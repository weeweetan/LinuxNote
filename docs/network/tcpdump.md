# tcpdump

[返回分类目录](../README.md#network) · [排障路线](../troubleshooting.md)

按主机、端口和方向捕获网络报文。

## 常用示例

```bash
sudo tcpdump -i eth0 -nn -c 100 'tcp port 443'
sudo tcpdump -i eth0 -nn -c 100 'host 192.0.2.10 and src port 443'
sudo tcpdump -i eth0 -nn -s 0 -c 100 -w capture.pcap 'tcp port 443'
tcpdump -nn -r capture.pcap
```

## 使用说明

`-i` 选择接口，`-nn` 不解析主机和服务名，`-c` 限制包数，`-w` 保存原始报文，`-r` 离线读取，`-A` 显示 ASCII，`-v` 增加详情。BPF 过滤表达式需要引号。

pcap 可能包含应用数据；TLS 内容通常是密文，抓包不等于自动解密。

## 参考

[命令手册](https://www.tcpdump.org/manpages/tcpdump.1.html)；实际选项以本机安装版本的手册为准。
