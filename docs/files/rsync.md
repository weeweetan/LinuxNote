# rsync

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

同步目录并先预览变化。

## 常用示例

```bash
rsync -avhn ./source/ ./backup/
rsync -avh ./source/ ./backup/
```

## 使用说明

`-n` 为试运行；`-a` 为归档模式；源路径结尾 `/` 表示复制目录内容，不带 `/` 时复制目录本身。默认不会删除目标中额外的文件，添加 `--delete` 会改变这一行为，应先带 `-n` 检查。

## 参考

[命令手册](https://download.samba.org/pub/rsync/rsync.1)；实际选项以本机安装版本的手册为准。
