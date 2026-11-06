# systemctl

[返回分类目录](../README.md#services) · [排障路线](../troubleshooting.md)

查看 systemd 服务状态、定义和日志。

## 常用示例

```bash
systemctl status nginx.service --no-pager
systemctl is-active nginx.service
systemctl is-enabled nginx.service
systemctl cat nginx.service
journalctl -u nginx.service -n 100 --no-pager
```

## 使用说明

将 nginx 替换为实际服务名。`start/stop/restart` 改变当前状态，`enable/disable` 改变开机启用状态；`enable` 本身不会立即启动服务。编辑 unit 文件后通常需 `daemon-reload`，它并不重启服务。

本页适用于运行 systemd 的 Linux；容器内未必存在 systemd。查询命令在服务不存在或未运行时可返回非零状态。

## 参考

[命令手册](https://www.freedesktop.org/software/systemd/man/latest/systemctl.html)；实际选项以本机安装版本的手册为准。
