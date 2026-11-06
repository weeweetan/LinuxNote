# less

[返回分类目录](../README.md#text) · [排障路线](../troubleshooting.md)

分页阅读大文件并搜索上下文。

## 常用示例

```bash
less app.log
less +G app.log
less -N config.conf
```

## 使用说明

进入后：`/pattern` 向后搜索，`?pattern` 向前搜索，`n` 下一个匹配，`N` 反向匹配，`g` 文件开头，`G` 末尾，`F` 跟踪增长（Ctrl-C 返回浏览），`q` 退出。

## 参考

[命令手册](https://www.greenwoodsoftware.com/less/)；实际选项以本机安装版本的手册为准。
