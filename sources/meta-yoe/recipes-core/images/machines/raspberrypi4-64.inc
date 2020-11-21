KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

KERNEL_ARTEFACTS = "\
    ${KERNEL_IMAGETYPE} \
    bcm2711-rpi-4-b.dtb \
"
DTBOFILES = "\
    overlays/at86rf233.dtbo \
    overlays/disable-bt.dtbo \
    overlays/dwc2.dtbo \
    overlays/gpio-ir.dtbo \
    overlays/gpio-ir-tx.dtbo \
    overlays/gpio-key.dtbo \
    overlays/hifiberry-amp.dtbo \
    overlays/hifiberry-dac.dtbo \
    overlays/hifiberry-dacplus.dtbo \
    overlays/hifiberry-digi.dtbo \
    overlays/i2c-rtc.dtbo \
    overlays/imx219.dtbo \
    overlays/iqaudio-dac.dtbo \
    overlays/iqaudio-dacplus.dtbo \
    overlays/mcp2515-can0.dtbo \
    overlays/mcp2515-can1.dtbo \
    overlays/miniuart-bt.dtbo \
    overlays/pitft22.dtbo \
    overlays/pitft28-capacitive.dtbo \
    overlays/pitft28-resistive.dtbo \
    overlays/pitft35-resistive.dtbo \
    overlays/pps-gpio.dtbo \
    overlays/rpi-ft5406.dtbo \
    overlays/rpi-poe.dtbo \
    overlays/vc4-fkms-v3d.dtbo \
    overlays/vc4-kms-v3d.dtbo \
    overlays/w1-gpio.dtbo \
    overlays/w1-gpio-pullup.dtbo \
    "

ROOTFS_ARTEFACTS = "rootfs.tar.xz"

BOOTLOADER_ARTEFACTS = "\
    boot.scr \
    kernel8.img \
    "
BOOTFILES = "\
    bootcode.bin \
    bootfiles-20201002.stamp \
    cmdline.txt \
    config.txt \
    fixup4cd.dat \
    fixup4.dat \
    fixup4db.dat \
    fixup4x.dat \
    fixup_cd.dat \
    fixup.dat \
    fixup_db.dat \
    fixup_x.dat \
    start4cd.elf \
    start4db.elf \
    start4.elf \
    start4x.elf \
    start_cd.elf \
    start_db.elf \
    start.elf \
    start_x.elf \
    "
UPDATE_IMAGES = "version.txt ${BOOTFILES} ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${DTBOFILES} ${ROOTFS_ARTEFACTS}"

do_updater() {
        echo "IMG_VERSION = ${IMG_VERSION}"
        rm -rf ${TOPDIR}/deploy/${MACHINE}
        install -d ${TOPDIR}/deploy/${MACHINE}
        cd ${TOPDIR}/deploy/${MACHINE}
        echo "${IMG_VERSION}" > version.txt
        # rootfs
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.tar.xz ${ROOTFS_ARTEFACTS}
        # bootloader
        install ${DEPLOY_DIR_IMAGE}/u-boot.bin kernel8.img
        install ${DEPLOY_DIR_IMAGE}/boot.scr boot.scr
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
        install ${DEPLOY_DIR_IMAGE}/yoe-installer-image-${MACHINE}.wic.xz ${TOPDIR}/deploy/${MACHINE}_${IMG_VERSION}.wic.xz
        install ${DEPLOY_DIR_IMAGE}/yoe-installer-image-${MACHINE}.wic.bmap ${TOPDIR}/deploy/${MACHINE}_${IMG_VERSION}.wic.bmap
        rm -rf ${TOPDIR}/deploy/${MACHINE}
}
