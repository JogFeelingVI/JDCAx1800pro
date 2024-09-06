## 如何扩容
> 扩容需要对应的u-boot文件，及扩容gpt分区表。这位大神提供了详细的方法！见`参考链接[1]`
> 
> 文件名为 `京东云AX1800-Pro亚瑟_AX6600雅典娜分区备份+TTL双分区刷机+回原厂+USB救砖文件20240510.7z`
>
> 需要访问到 `github`，如果不能顺利访问GitHub，可以通过cdns的方式来访问，百度即可知。

## 资源说明
> 512m = `rootfs` + `overlay`
>
> overlay = 512-83 = 429, 429就是安装完固件overlay的大小，83是固件大小。
>
> 反正 `0p27` 号分区对于原厂固件游泳池，对于其他固件没得用。

1. [uboot-JDC_AX1800](uboot-JDC_AX1800_Pro-AX6600_Athena-20240510.bin) `不死u-boot`
2. [512mGPT](gpt-JDC_AX1800_Pro_dual-boot_rootfs512M_no-last-partition.bin)
3. [1024mGPT](gpt-JDC_AX1800_Pro_dual-boot_rootfs1024M_no-last-partition.bin)
4. [2048mGPT](gpt-JDC_AX1800_Pro_dual-boot_rootfs2048M_no-last-partition.bin)

## 刷u-boot方法
* 参考[uboot.md](uboot.md)
* 方法一样,我使用的是sda方式,在操作系统中挂smb,然后把所需要的文件up到sda,然后通过ssh刷写。

## 刷分区表 gpt
> 将对应的分区表上传到`sda`,然后使用下面的命令刷入。我使用的是2048版的。毕竟弄大一点。以后想怎么玩都不受限制。
>

### 注意核对gpt信息
* 9d9e3803ba541ff38449acd181026b28 gpt-JDC_AX1800_Pro_dual-boot_rootfs512M_no-last-partition.bin

* 5aaf1b606458fbffc72342540db9bc52  gpt-JDC_AX1800_Pro_dual-boot_rootfs1024M_no-last-partition.bin
* b93b4823af2b4fc31d22c25468181e7a  gpt-JDC_AX1800_Pro_dual-boot_rootfs2048M_no-last-partition.bin

### Shell 执行记录

```shell
root@iStoreOS:/mnt/sda2/mmcback# dd if=./uboot-JDC_AX1800_Pro-AX6600_Athena-20240510.bin of=$(blkid -t PARTLABEL=0:APPSBL -o device) conv
=fsync
1280+0 records in
1280+0 records out
root@iStoreOS:/mnt/sda2/mmcback# dd if=./uboot-JDC_AX1800_Pro-AX6600_Athena-20240510.bin of=$(blkid -t PARTLABEL=0:APPSBL_1 -o device) co
nv=fsync
1280+0 records in
1280+0 records out
root@iStoreOS:/mnt/sda2/mmcback# md5sum $(blkid -t PARTLABEL=0:APPSBL -o device) && md5sum $(blkid -t PARTLABEL=0:APPSBL_1 -o device)
5e1817f795ada48335fda9f22545a43e  /dev/mmcblk0p13
5e1817f795ada48335fda9f22545a43e  /dev/mmcblk0p14
root@iStoreOS:/mnt/sda2/mmcback# md5sum ./gpt-JDC_AX1800_Pro_dual-boot_rootfs2048M_no-last-partition.bin
b93b4823af2b4fc31d22c25468181e7a  ./gpt-JDC_AX1800_Pro_dual-boot_rootfs2048M_no-last-partition.bin
root@iStoreOS:/mnt/sda2/mmcback# dd if=./gpt-JDC_AX1800_Pro_dual-boot_rootfs2048M_no-last-partition.bin of=/dev/mmcblk0 bs=512 count=34 c
onv=fsync
34+0 records in
34+0 records out
root@iStoreOS:/mnt/sda2/mmcback# dd if=/dev/mmcblk0 bs=512 count=34 | md5sum
34+0 records in
34+0 records out
b93b4823af2b4fc31d22c25468181e7a  -
```

### 刷写完毕，可以重启进入u-boot 刷写第三方op


### 参考链接
1. https://github.com/lgs2007m/Actions-OpenWrt/blob/main/%E5%88%B7%E6%9C%BA%E6%95%99%E7%A8%8B/%E4%BA%AC%E4%B8%9C%E4%BA%91AX1800-Pro%E4%BA%9A%E7%91%9F_AX6600%E9%9B%85%E5%85%B8%E5%A8%9C%E5%88%86%E5%8C%BA%E5%A4%87%E4%BB%BD%2BTTL%E5%8F%8C%E5%88%86%E5%8C%BA%E5%88%B7%E6%9C%BA%2B%E5%9B%9E%E5%8E%9F%E5%8E%82%2BUSB%E6%95%91%E7%A0%96%E6%95%99%E7%A8%8B20240510.md