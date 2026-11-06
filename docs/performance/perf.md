# perf

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

采样程序热点和调用栈。

## 常用示例

```bash
perf stat -- ./program
perf top -p 1234
perf record -g -p 1234 -- sleep 10
perf report -i perf.data
```

## 使用说明

`program` 和 `1234` 需替换。perf 工具、内核事件权限和调试符号影响可用性。调用栈质量取决于 frame pointer 或选用的 DWARF 等回溯方式；默认 `-g` 不保证所有程序都能完整展开。

`record` 写入采样文件，`report` 离线读取；采样也有开销，应限制时间。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/perf-record.1.html)；实际选项以本机安装版本的手册为准。
