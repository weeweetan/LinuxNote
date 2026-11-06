# ac / lastcomm

[返回分类目录](../README.md#services) · [排障路线](../troubleshooting.md)

查看登录时长和已记录的进程记账信息。

## 常用示例

```bash
ac -p
lastcomm
sa
```

## 使用说明

工具通常来自 acct/psacct：`ac` 汇总登录连接时长，`lastcomm` 读取已完成命令的进程记账记录，`sa` 汇总记账信息，`accton` 控制进程记账。

登录记录与进程记账是不同数据源；没有预先启用记账，不能事后恢复全部执行历史。权限、日志轮转和发行版配置会影响结果。

## 参考

[命令手册](https://www.gnu.org/software/acct/manual/accounting.html)；实际选项以本机安装版本的手册为准。
