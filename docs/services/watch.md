# watch

[返回分类目录](../README.md#services) · [排障路线](../troubleshooting.md)

按固定间隔重复显示命令结果。

## 常用示例

```bash
watch -n 2 -d 'free -h'
watch -n 1 'ss -s'
```

## 使用说明

默认间隔通常为 2 秒，`-n` 显式设置，`-d` 高亮变化。管道或重定向若要在每轮执行，须放进引号交给 watch 执行的 shell。使用 Ctrl-C 退出。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/watch.1.html)；实际选项以本机安装版本的手册为准。
