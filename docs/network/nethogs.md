# NetHogs

[返回分类目录](../README.md#network) · [排障路线](../troubleshooting.md)

按进程定位带宽使用者。

## 常用示例

```bash
sudo nethogs eth0
sudo nethogs -d 2 eth0
```

## 使用说明

将 `eth0` 替换为实际接口；`-d` 指定刷新间隔。需要捕获网络流量的权限。进程归属可能受网络命名空间、短生命周期连接和权限影响，未知流量不应直接认定为异常进程。

## 参考

[命令手册](https://github.com/raboof/nethogs)；实际选项以本机安装版本的手册为准。
