KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

KERNEL_ARTEFACTS = "\
    ${KERNEL_IMAGETYPE} \
    meson64_odroidc4.dtb \
    ads7846.dtbo \
    can0.dtbo \
    esp8089.dtbo \
    fanspeed-full.dtbo \
    hifishield2.dtbo \
    hifishield.dtbo \
    hktft32.dtbo \
    hktft35.dtbo \
    i2c0.dtbo \
    i2c1.dtbo \
    lineout.dtbo \
    onewire.dtbo \
    pcf8563.dtbo \
    pwm_ab.dtbo \
    pwm_a-pwmfan.dtbo \
    pwm_b-backlight.dtbo \
    pwm_cd.dtbo \
    pwm_ef.dtbo \
    sdio.dtbo \
    spi0.dtbo \
    sx865x-i2c1.dtbo \
    uart0.dtbo \
    uart1.dtbo \
    uart2.dtbo \
    "

ROOTFS_ARTEFACTS = "rootfs.tar.xz"

BOOTLOADER_ARTEFACTS = "\
    u-boot.bin \
    boot.ini \
    config.ini \
    "
UPDATE_IMAGES = "version.txt ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${ROOTFS_ARTEFACTS}"

do_updater() {
        echo "IMG_VERSION = ${IMG_VERSION}"
        install -d ${TOPDIR}/deploy
        cd ${TOPDIR}/deploy
        echo "${IMG_VERSION}" > version.txt
        install ${DEPLOY_DIR_IMAGE}/yoe-installer-image-${MACHINE}.wic.xz ${MACHINE}_${IMG_VERSION}.wic.xz
        install ${DEPLOY_DIR_IMAGE}/yoe-installer-image-${MACHINE}.wic.bmap ${MACHINE}_${IMG_VERSION}.wic.bmap
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.tar.xz ${ROOTFS_ARTEFACTS}
        for f in ${KERNEL_ARTEFACTS} ${BOOTLOADER_ARTEFACTS}
        do
            install ${DEPLOY_DIR_IMAGE}/$f $f
        done
        # Match kernel image with wic
        rm ${KERNEL_IMAGETYPE}
        install ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGE} ${KERNEL_IMAGETYPE}
        sha256sum ${UPDATE_IMAGES}  > update.sha256
        rm -rf ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        ls ${UPDATE_IMAGES_} | cpio -ov -H newc > ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        rm -rf ${UPDATE_IMAGES_}
}
