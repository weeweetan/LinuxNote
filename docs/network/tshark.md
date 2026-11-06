# tshark

[返回分类目录](../README.md#network) · [排障路线](../troubleshooting.md)

离线解析 pcap 并提取协议字段。

## 常用示例

```bash
tshark -r capture.pcap -Y 'tcp.port == 443'
tshark -r capture.pcap -Y 'tcp.analysis.retransmission'
tshark -r capture.pcap -T fields -e frame.time -e ip.src -e ip.dst -e tcp.dstport
```

## 使用说明

来自 Wireshark。`-f` 是捕获过滤器（BPF 语法），`-Y` 是显示过滤器（Wireshark 语法），不能混用。分析重传标记时还应考虑抓包丢失、截断和抓包点位置。

## 参考

[命令手册](https://www.wireshark.org/docs/man-pages/tshark.html)；实际选项以本机安装版本的手册为准。
