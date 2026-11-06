# uniq

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

合并相邻重复行并统计出现次数。

## 常用示例

```bash
uniq adjacent.txt
sort names.txt | uniq -c | sort -nr
sort names.txt | uniq -d
```

## 使用说明

`uniq` 本身不会排序，只比较相邻行。`-c` 统计每组出现次数，`-d` 只输出重复组。若需保留原始顺序去重，可用 `awk '!seen[$0]++' names.txt`。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/uniq.1.html)；实际选项以本机安装版本的手册为准。
