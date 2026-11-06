# ldd

[返回分类目录](../README.md#debugging) · [排障路线](../troubleshooting.md)

查看可信可执行文件的动态库依赖。

## 常用示例

```bash
ldd /bin/ls
objdump -p ./program | grep NEEDED
```

## 使用说明

`ldd` 用于可信文件；某些实现或特殊解释器可能执行目标代码，不要对不可信下载文件使用。`objdump -p` 可静态检查直接声明的依赖，但不会像动态加载器那样解析完整依赖树。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/ldd.1.html)；实际选项以本机安装版本的手册为准。
