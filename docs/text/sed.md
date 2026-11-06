# sed

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

按行筛选、替换或追加文本。

## 常用示例

```bash
sed -n '1,20p' app.log
sed '/^#/d' config.conf
sed 's/old/new/g' input.txt
# 确认输出后，原地修改并保留 .bak 备份（GNU sed）
sed -i.bak 's/old/new/g' input.txt
```

## 使用说明

默认输出到标准输出；`-i` 才修改源文件。`d` 删除匹配行，`a` 追加内容，`s` 替换。用户提供的字符串不能不经处理就拼进正则或替换表达式；替换部分的 `&` 代表整个匹配。

GNU 与 BSD/macOS 的 `-i` 参数形式有差异，跨平台脚本优先写入新文件。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/sed.1.html)；实际选项以本机安装版本的手册为准。
