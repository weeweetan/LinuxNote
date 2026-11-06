# objdump

[返回分类目录](../README.md#debugging) · [排障路线](../troubleshooting.md)

查看 ELF 段、符号和反汇编。

## 常用示例

```bash
objdump -h ./program
objdump -t ./program
objdump -d -C ./program
objdump -S ./program
```

## 使用说明

`-h` 查看节头，`-t` 查看符号表，`-d` 反汇编代码节，`-C` 还原 C++ 名称。`-S` 混合源码需要调试信息和可访问的源码；优化后的指令顺序未必对应源码顺序。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/objdump.1.html)；实际选项以本机安装版本的手册为准。
