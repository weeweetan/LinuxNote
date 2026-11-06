# declare

[返回分类目录](../README.md#shell) · [排障路线](../troubleshooting.md)

声明 Bash 数组和变量属性。

## 常用示例

```bash
declare -a names=('alice' 'bob')
printf '%s\n' "${names[@]}"

# 关联数组需要 Bash 4+
declare -A ports=([http]=80 [https]=443)
printf '%s\n' "${ports[https]}"
```

## 使用说明

`-a` 声明索引数组，`-A` 声明关联数组，`-r` 声明只读变量。`declare -i` 会把赋值作为算术表达式求值，不等于安全地校验数字输入。macOS 自带 Bash 3.2 不支持关联数组。

## 参考

[命令手册](https://www.gnu.org/software/bash/manual/html_node/Arrays.html)；实际选项以本机安装版本的手册为准。
