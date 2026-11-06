# awk

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

按字段提取、聚合与去重。

## 常用示例

```bash
awk -F ',' '{print $2}' data.csv
awk '{sum += $12} END {print sum + 0}' access.log
awk '{sum += $12} END {if (NR) print sum / NR}' access.log
awk '!seen[$1, $4]++' data.txt
awk '{print $NF}' data.txt
```

## 使用说明

`$0` 是整行，`$1` 是第一列，`NF` 是当前记录的字段数，`NR` 是已读记录数。最后一列应写 `$NF`，不是 `$NR`。多文件输入时 `NR` 继续累计。

简单的 `-F ','` 适用于字段中没有带引号逗号的文本；完整 CSV 应使用 CSV 解析器。均值示例假定第 12 列都是有效数值。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/awk.1p.html)；实际选项以本机安装版本的手册为准。
