# xargs

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

将标准输入转换为命令参数。

## 常用示例

```bash
find . -type f -name '*.log' -print0 | xargs -0 -r wc -l
printf '%s\0' 'hello world' 'another file' | xargs -0 -n 1 printf '<%s>\n'
```

## 使用说明

文件名可能包含空格、引号甚至换行，应成对使用 `-print0` / `-0`。GNU `-r` 在没有输入时不运行命令。`-n` 限制每次参数数量，`-P` 控制并行进程数。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/xargs.1.html)；实际选项以本机安装版本的手册为准。
