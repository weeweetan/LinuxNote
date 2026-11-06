# echo / printf

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

输出文本，使用 printf 明确控制格式。

## 常用示例

```bash
message='hello world'
printf '%s\n' "$message"
printf '%s' 'without newline'
printf 'name=%s count=%d\n' 'demo' 3
```

## 使用说明

`echo -n` 通常省略末尾换行，但不同 shell 对选项与转义的处理存在差异。脚本中优先使用 `printf '%s\n' "$value"`；不要把不受控输入直接当作 printf 的格式字符串。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/printf.1.html)；实际选项以本机安装版本的手册为准。
