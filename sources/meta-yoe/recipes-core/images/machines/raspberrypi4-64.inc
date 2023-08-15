# We use updater to handle disk/SD management, therefore remove 96boards-tools
IMAGE_INSTALL:remove = "96boards-tools"

KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

# Add ${KERNEL_IMAGETYPE} to KERNEL_ARTEFACTS if using u-boot
KERNEL_ARTEFACTS = "\
    bcm2711-rpi-4-b.dtb \
    bcm2711-rpi-400.dtb \
    bcm2711-rpi-cm4.dtb \
    bcm2711-rpi-cm4s.dtb \
"
DTBOFILES = " ${RPI_KERNEL_DEVICETREE_OVERLAYS} "

ROOTFS_ARTEFACTS = "rootfs.ext4.xz"

BOOTLOADER_ARTEFACTS = "\
    kernel8.img \
    "
# uncomment when using u-boot
#BOOTLOADER_ARTEFACTS += "boot.scr"

BOOTFILES = "\
    bootcode.bin \
    cmdline.txt \
    config.txt \
    fixup.dat \
    fixup4.dat \
    fixup4cd.dat \
    fixup4db.dat \
    fixup4x.dat \
    fixup_cd.dat \
    fixup_db.dat \
    fixup_x.dat \
    start.elf \
    start4.elf \
    start4cd.elf \
    start4db.elf \
    start4x.elf \
    start_cd.elf \
    start_db.elf \
    start_x.elf \
    "
UPDATE_IMAGES = "version.txt ${BOOTFILES} ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${DTBOFILES} ${ROOTFS_ARTEFACTS}"

do_updater() {
        echo "IMG_VERSION = ${IMG_VERSION}"
        rm -rf ${TOPDIR}/deploy/${MACHINE}
        install -d ${TOPDIR}/deploy/${MACHINE}
        OLDPWD="$PWD"
        cd ${TOPDIR}/deploy/${MACHINE}
        echo "${IMG_VERSION}" > version.txt
        # rootfs
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}.ext4.xz ${ROOTFS_ARTEFACTS}
        # uncomment when using uboot
        #install ${DEPLOY_DIR_IMAGE}/u-boot.bin kernel8.img
        #install ${DEPLOY_DIR_IMAGE}/boot.scr boot.scr
        # use when not using uboot ( note that it should be kernel with initramfs )
        install ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGE} kernel8.img
        for f in ${BOOTFILES}
        do
            install ${DEPLOY_DIR_IMAGE}/bootfiles/$f $f
        done
        # kernel
        for f in ${KERNEL_ARTEFACTS}
        do
            install ${DEPLOY_DIR_IMAGE}/$f `basename $f`
        done
        # Match kernel image with wic
        install ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGE} ${KERNEL_IMAGETYPE}
        for f in ${DTBOFILES}
        do
            install -D ${DEPLOY_DIR_IMAGE}/`basename $f` $f
        done

        sha256sum ${UPDATE_IMAGES}  > update.sha256
        rm -rf ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        ls ${UPDATE_IMAGES_} | cpio -ov -H newc > ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        install ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd ${DEPLOY_DIR_IMAGE}/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        cd ${OLDPWD}
        rm -rf ${TOPDIR}/deploy/${MACHINE}
}
