# vim

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

搜索、分屏与批量编辑速查。

## 常用示例

```bash
vim file.txt
```

## 使用说明

在普通模式按 `:` 进入命令行：

- `/pattern` 正向搜索，`?pattern` 反向搜索；`n` 继续，`N` 反向。
- `:vsplit other.txt` 垂直分屏，Ctrl-W 后按方向键切换。
- 在需要同步滚动的窗口分别执行 `:set scrollbind`。
- `:%s/pattern//gn` 统计匹配次数，不执行替换。
- `:1,5normal I#` 给第 1–5 行加注释前缀。
- `:%s/^#//` 删除所有行的首个 `#`。
- 若终端因 Ctrl-S 停止输出，可用 Ctrl-Q 恢复；这是终端流控。

## 参考

[命令手册](https://vimhelp.org/quickref.txt.html)；实际选项以本机安装版本的手册为准。
