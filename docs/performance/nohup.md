# nohup

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

让命令忽略挂断信号并明确重定向输出。

## 常用示例

```bash
nohup bash ./job.sh >job.log 2>&1 < /dev/null &
printf 'PID=%s\n' "$!"
```

## 使用说明

`nohup` 自身不会把进程放到后台，后台执行来自 `&`。它不负责故障重启、依赖管理或机器重启后拉起；长期服务应交给服务管理器。`job.sh` 为待运行脚本。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/nohup.1.html)；实际选项以本机安装版本的手册为准。
