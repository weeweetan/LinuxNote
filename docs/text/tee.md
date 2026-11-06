# tee

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

将管道内容同时显示并写入文件。

## 常用示例

```bash
printf '%s\n' 'hello' | tee output.txt
printf '%s\n' 'next line' | tee -a output.txt
```

## 使用说明

默认覆盖目标文件，`-a` 改为追加。管道默认返回最后一条命令的状态；Bash 中如需捕获前段失败，可使用 `set -o pipefail`。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/tee.1.html)；实际选项以本机安装版本的手册为准。
