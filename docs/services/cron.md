# cron

[返回分类目录](../README.md#services) · [排障路线](../troubleshooting.md)

编写用户 crontab 并明确运行环境。

## 常用示例

```bash
crontab -l
crontab -e
```

## 使用说明

用户 crontab 的格式是“分 时 日 月 周 命令”，例如：

```cron
SHELL=/bin/bash
PATH=/usr/local/bin:/usr/bin:/bin
# 每分钟；将路径替换为实际脚本与日志路径
* * * * * /absolute/path/job.sh >> /absolute/path/job.log 2>&1
# 每小时第 3 和第 15 分钟
3,15 * * * /absolute/path/job.sh
# 每天 8–11 点的第 3 和第 15 分钟
3,15 8-11 * * * /absolute/path/job.sh
```

系统 `/etc/crontab` 还有用户名列，不能原样复制用户格式。`*/2` 放在“日”字段表示在每个月的日期范围内步进，不保证连续每 48 小时运行。cron 的环境与交互终端不同，使用绝对路径；命令中的 `%` 有特殊含义。

## 参考

[命令手册](https://man7.org/linux/man-pages/man5/crontab.5.html)；实际选项以本机安装版本的手册为准。
