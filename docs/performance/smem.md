# smem

[返回分类目录](../README.md#performance) · [排障路线](../troubleshooting.md)

用 USS、PSS、RSS 观察进程内存。

## 常用示例

```bash
smem -tk
smem -r -s pss
smem -P 'nginx' -k
```

## 使用说明

USS 是进程独占的驻留内存；PSS 按共享进程数分摊共享页；RSS 计入全部驻留页。`-t` 显示总计，`-k` 使用易读单位，`-s` 指定排序列，`-r` 反向。读取完整进程集合需要相应权限。

## 参考

[命令手册](https://www.selenic.com/smem/)；实际选项以本机安装版本的手册为准。
