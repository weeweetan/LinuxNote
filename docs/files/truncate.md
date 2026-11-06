# truncate

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

缩小或扩展文件长度。

## 常用示例

```bash
printf '%s\n' 'temporary content' > example.log
truncate -s 0 example.log
truncate -s 1M example.bin
```

## 使用说明

`-s 0` 会丢弃全部内容，文件不存在时默认创建。扩展出的部分读取为零字节，可能是稀疏区域。

截断不保证与其他写入进程互斥，也不会重置它们持有的文件偏移；持续写入日志应采用服务支持的日志轮转机制。

## 参考

[命令手册](https://man7.org/linux/man-pages/man2/truncate.2.html)；实际选项以本机安装版本的手册为准。
