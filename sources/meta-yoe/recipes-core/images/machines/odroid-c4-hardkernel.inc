KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

KERNEL_ARTEFACTS = "\
    ${KERNEL_IMAGETYPE} \
    meson64_odroidc4.dtb \
    "
DTBO_ARTEFACTS = "\
    amlogic/overlays/odroidc4/ads7846.dtbo \
    amlogic/overlays/odroidc4/can0.dtbo \
    amlogic/overlays/odroidc4/esp8089.dtbo \
    amlogic/overlays/odroidc4/fanspeed-full.dtbo \
    amlogic/overlays/odroidc4/hifishield2.dtbo \
    amlogic/overlays/odroidc4/hifishield.dtbo \
    amlogic/overlays/odroidc4/hktft32.dtbo \
    amlogic/overlays/odroidc4/hktft35.dtbo \
    amlogic/overlays/odroidc4/i2c0.dtbo \
    amlogic/overlays/odroidc4/i2c1.dtbo \
    amlogic/overlays/odroidc4/lineout.dtbo \
    amlogic/overlays/odroidc4/onewire.dtbo \
    amlogic/overlays/odroidc4/pcf8563.dtbo \
    amlogic/overlays/odroidc4/pwm_ab.dtbo \
    amlogic/overlays/odroidc4/pwm_a-pwmfan.dtbo \
    amlogic/overlays/odroidc4/pwm_b-backlight.dtbo \
    amlogic/overlays/odroidc4/pwm_cd.dtbo \
    amlogic/overlays/odroidc4/pwm_ef.dtbo \
    amlogic/overlays/odroidc4/sdio.dtbo \
    amlogic/overlays/odroidc4/spi0.dtbo \
    amlogic/overlays/odroidc4/sx865x-i2c1.dtbo \
    amlogic/overlays/odroidc4/uart0.dtbo \
    amlogic/overlays/odroidc4/uart1.dtbo \
    amlogic/overlays/odroidc4/uart2.dtbo \
    "

ROOTFS_ARTEFACTS = "rootfs.tar.xz"

BOOTLOADER_ARTEFACTS = "\
    u-boot.bin \
    boot.ini \
    config.ini \
    "
UPDATE_IMAGES = "version.txt ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${DTBO_ARTEFACTS} ${ROOTFS_ARTEFACTS}"

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

        for f in ${DTBO_ARTEFACTS}
        do
            install -D ${DEPLOY_DIR_IMAGE}/`basename $f` $f
        done
        # Match kernel image with wic
        rm ${KERNEL_IMAGETYPE}
        install ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGE} ${KERNEL_IMAGETYPE}
        sha256sum ${UPDATE_IMAGES}  > update.sha256
        rm -rf ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        ls ${UPDATE_IMAGES_} | cpio -ov -H newc > ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        rm -rf ${UPDATE_IMAGES_}
}
