# sort

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

对文本按整行、数值或指定列排序。

## 常用示例

```bash
LC_ALL=C sort names.txt
sort -n numbers.txt
sort -k2,2n data.txt
sort -u names.txt
```

## 使用说明

`-k2,2n` 只使用第 2 列进行数值排序；`-k2` 会从第 2 列一直比较到行末。默认排序受 locale 影响，设置 `LC_ALL=C` 可获得按字节顺序的稳定结果。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/sort.1.html)；实际选项以本机安装版本的手册为准。
