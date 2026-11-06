# IFS / read

[返回分类目录](../README.md#shell) · [排障路线](../troubleshooting.md)

控制字段分割并逐行保留原始文本。

## 常用示例

```bash
while IFS= read -r line || [[ -n "$line" ]]; do
    printf '%s\n' "$line"
done < input.txt

IFS=: read -r name passwd uid rest <<< 'demo:x:1000:1000:Demo:/home/demo:/bin/bash'
printf 'name=%s uid=%s\n' "$name" "$uid"
```

## 使用说明

IFS 是 shell 变量，不是独立命令。`IFS= read -r` 保留行首尾空白和反斜杠；循环中的补充条件保留末尾无换行的一行。给单条 read 设置 IFS 可避免影响后续命令。

## 参考

[命令手册](https://www.gnu.org/software/bash/manual/html_node/Word-Splitting.html)；实际选项以本机安装版本的手册为准。
