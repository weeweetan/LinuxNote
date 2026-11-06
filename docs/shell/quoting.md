# 引用与转义

[返回分类目录](../README.md#shell) · [排障路线](../troubleshooting.md)

区分字面字符、变量展开和 shell 操作符。

## 常用示例

```bash
value='hello world'
printf '%s\n' "$value"
printf '%s\n' '$value stays literal'
printf '%s\n' 'a&b' 'a|b' 'a*b'
printf '%s\n' "it's quoted"
```

## 使用说明

单引号保留内部字符的字面值；双引号允许变量展开，同时阻止展开结果的单词分割与文件名扩展。裸露的 `&` 会把命令放到后台，`'&'` 或 `\&` 才表示字面字符。

始终区分 shell 引用、正则转义和 JSON 转义，它们是不同层的语法。

## 参考

[命令手册](https://www.gnu.org/software/bash/manual/html_node/Quoting.html)；实际选项以本机安装版本的手册为准。
