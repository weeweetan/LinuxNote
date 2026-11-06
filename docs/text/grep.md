# grep

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

按模式查找文本并显示位置。

## 常用示例

```bash
grep -nF -- 'connection refused' app.log
grep -rni --include='*.log' -- 'error' ./logs
grep -Ev -- 'debug|trace' app.log
```

## 使用说明

`-F` 匹配字面字符串，`-E` 使用扩展正则，`-i` 忽略大小写，`-v` 反选。`-P` 是 PCRE 模式，取决于构建支持。

正则中的 `*` 表示重复前一个表达式，不等同于文件名通配符。退出码 0 为有匹配、1 为无匹配、2 为错误；脚本要区分后两者。

## 参考

[命令手册](https://man7.org/linux/man-pages/man1/grep.1.html)；实际选项以本机安装版本的手册为准。
