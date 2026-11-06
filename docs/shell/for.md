# for

[返回分类目录](../README.md#shell) · [排障路线](../troubleshooting.md)

遍历参数、文件和数值序列。

## 常用示例

```bash
for item in one two three; do
    printf '%s\n' "$item"
done

for argument in "$@"; do
    printf '<%s>\n' "$argument"
done

for ((i = 1; i <= 3; i++)); do
    printf '%d\n' "$i"
done
```

## 使用说明

省略 `in ...` 时，`for argument; do ...; done` 默认遍历 `"$@"`；可以省略的是 `in` 列表，循环变量不能省略。参数和文件名展开应保留引号。

## 参考

[命令手册](https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html)；实际选项以本机安装版本的手册为准。
