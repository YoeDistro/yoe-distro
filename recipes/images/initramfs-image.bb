# will be used for the update image
DESCRIPTION = "initramfs updater image"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=3f40d7994397109285ec7b81fdeb3b58 \
                    file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

#IMAGE_INSTALL = "task-core-boot ${ROOTFS_PKGMANAGE_BOOTSTRAP} ${POKY_EXTRA_INSTALL}"

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""

export IMAGE_BASENAME = "initramfs-image"
IMAGE_LINGUAS = ""

LICENSE = "MIT"

IMAGE_INSTALL = "\
	base-files \
	base-passwd \
	busybox \
	mtd-utils \
	e2fsprogs \
	e2fsprogs-mke2fs \
	util-linux-fsck \
	e2fsprogs-e2fsck \
	e2fsprogs-tune2fs \
	psplash \
    "

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"
IMAGE_DEVICE_TABLES = "files/device_table-minimal.txt"
# remove not needed ipkg informations
ROOTFS_POSTPROCESS_COMMAND += "remove_packaging_data_files ; "

inherit core-image

