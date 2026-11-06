# jq

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

格式化 JSON，并提取对象或数组。

## 常用示例

```bash
jq '.' data.json
jq 'keys' data.json
jq -r '.name' data.json
jq '.items[]' data.json
jq '.items | map(select(.enabled == true))' data.json
```

## 使用说明

`keys` 是列出键的过滤器；`.keys` 是读取名为 `keys` 的字段。`.key` 与 `.["key"]` 都访问对象字段，遍历数组使用 `.[]`。`-r` 将字符串输出为原始文本。

## 参考

[命令手册](https://jqlang.org/manual/)；实际选项以本机安装版本的手册为准。
