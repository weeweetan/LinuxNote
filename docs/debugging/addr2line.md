# addr2line

[返回分类目录](../README.md#debugging) · [排障路线](../troubleshooting.md)

将程序地址映射为函数和源码行。

## 常用示例

```bash
addr2line -e ./program -f -C -i 0x401234
```

## 使用说明

需要匹配的二进制及调试信息，示例地址应替换为目标地址。`-f` 显示函数，`-C` 还原 C++ 名称，`-i` 展示内联调用。

PIE/共享库的运行时地址需要按 ELF 加载偏移换算；`/proc/PID/maps` 的映射起始地址、文件偏移与 ELF 段布局都相关，不能一律减去“第一行起始地址”。缺失符号或地址不匹配时可能返回 `??`。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/addr2line.1.html)；实际选项以本机安装版本的手册为准。
