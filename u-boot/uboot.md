## u-boot 刷机教程
> 此命令在正常ssh登陆路由器后才能使用
- https://github.com/0x5826/uboot-ipq60xx-build
```shell
curl -o u-boot.mbn http://oss-hk4.oss-cn-hongkong.aliyuncs.com/tmp/u-boot.mbn
ls -l /root/u-boot.mbn
# 确认文件大小相等 `644624`
dd if=/root/u-boot.mbn of=/dev/mmcblk0p13
# 刷入 0p13 磁盘
dd if=/root/u-boot.mbn of=/dev/mmcblk0p14
# 刷入 0p13 磁盘
```

## 如何进入Ax1800pro U-boot 界面
- 拔掉Wan口网线,USB线,只留与操作主机相连的RJ45网线。
- 短电的前提下,用牙签或其他可以插进 `reset` 空的东西插入`reset`并按压rest按钮。
- 接通电源,直到路由器上的不再闪烁，且为蓝色的时候即可松开`reset`
- 设置操作的电脑的ip为静态ip`192.168.1.10`,子网掩码`255.255.255.0`, 网关为`192.168.1.1`
- 用浏览器打开`http://192.168.1.1`,最好是`无痕模式`.

## 注意事项
> u-boot 刷入的固件即为路由器的操作系统,有格式限制,在JDC-Ax1800 Pro上 有格式及容量限制.切记.
> 默认没有进行 gpt 扩容的智能刷入60mb 的固件，扩容 /overlay 分区也不行，必须经过 gpt 扩容之后才可以使用大于 60mb 的固件。

- `istoreos-squashfs-factory.bin`  无需扩容, 刷写之后可以采用 扩容 `/overlay` 的方法。
- `iStoreOS-R24.05.19-ipq60xx-generic-jdcloud_ax1800-pro-squashfs-factory` 必须要扩容之后才能刷
- `iStoreOS-R24.05.19-ipq60xx-generic-jdcloud_ax1800-pro-squashfs-sysupgrade` 必须要扩容之后才能刷

