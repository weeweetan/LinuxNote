# md5sum / sha256sum

[返回分类目录](../README.md#files) · [排障路线](../troubleshooting.md)

生成和核对文件摘要。

## 常用示例

```bash
md5sum file.bin
sha256sum file.bin > SHA256SUMS
sha256sum -c SHA256SUMS
```

## 使用说明

MD5 可用于非对抗环境中的误传检查，但不适合安全完整性证明。校验下载内容时应使用可信渠道发布的摘要；仅从同一不可信来源获得文件和摘要不能验证真实性。

## 参考

[命令手册](https://www.gnu.org/software/coreutils/manual/html_node/cksum-common-options.html)；实际选项以本机安装版本的手册为准。
