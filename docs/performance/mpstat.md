# mpstat

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

按逻辑 CPU 查看使用情况。

## 常用示例

```bash
mpstat -P ALL 1 5
mpstat -P 0 1 5
```

## 使用说明

来自 sysstat。`-P ALL` 显示所有 CPU，`-P 0` 只看 CPU 0。只有指定采样间隔才会持续观测；关注单核热点时不要只看整机平均值。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/mpstat.1.html)；实际选项以本机安装版本的手册为准。
