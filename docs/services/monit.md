# monit

[返回分类目录](../README.md#services) · [排障路线](../troubleshooting.md)

检查 Monit 配置与已管理服务。

## 常用示例

```bash
monit -t
monit summary
monit status
```

## 使用说明

`-t` 检查配置语法；状态查询要求 Monit 守护进程及访问配置可用。自动重启来自具体监控规则，并非安装后自动接管所有进程。修改配置前确认 restart 条件与限频，避免反复拉起掩盖故障。

## 参考

[命令手册](https://www.mmonit.com/monit/documentation/monit.html)；实际选项以本机安装版本的手册为准。
