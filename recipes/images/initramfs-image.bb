# will be used for the update image
DESCRIPTION = "initramfs updater image"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""

export IMAGE_BASENAME = "initramfs-image"
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
  util-linux-fsck \
  e2fsprogs-e2fsck \
  e2fsprogs-tune2fs \
  "
IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
inherit core-image

IMAGE_DEVICE_TABLES = "files/device_table-minimal.txt"
IMAGE_ROOTFS_SIZE = "8192"
IMAGE_ROOTFS_EXTRA_SPACE = "0"
BAD_RECOMMENDATIONS += "busybox-syslog"

