# will be used for the update image
DESCRIPTION = "initramfs updater image"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""

export IMAGE_BASENAME = "yoe-initramfs-image"
IMAGE_LINGUAS = ""

PACKAGE_INSTALL = "\
  base-files \
  base-passwd \
  busybox \
  updater \
  mtd-utils \
  mtd-utils-ubifs \
  e2fsprogs \
  e2fsprogs-mke2fs \
  e2fsprogs-e2fsck \
  e2fsprogs-tune2fs \
  util-linux-fsck \
  util-linux-fdisk \
  "
IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
# Check conf/site.conf where there is IMAGE_FSTYPES:append
# if that value changes make the change here as well
IMAGE_FSTYPES:remove = "wic.* wic.xz wic.bmap tar.xz"
inherit core-image

IMAGE_DEVICE_TABLES = "files/device_table-minimal.txt"
IMAGE_ROOTFS_SIZE = "8192"
IMAGE_ROOTFS_EXTRA_SPACE = "0"
BAD_RECOMMENDATIONS += "busybox-syslog busybox-udhcpc"
