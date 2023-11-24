# We use updater to handle disk/SD management, therefore remove 96boards-tools
IMAGE_INSTALL:remove = "96boards-tools"

KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

KERNEL_ARTEFACTS = "\
    ${KERNEL_IMAGETYPE} \
    imx6ul-var-dart-6ulcustomboard-emmc-sd-card.dtb \
    imx6ul-var-dart-6ulcustomboard-emmc-wifi.dtb \
    imx6ul-var-dart-6ulcustomboard-nand-sd-card.dtb \
    imx6ul-var-dart-6ulcustomboard-nand-wifi.dtb \
    "
DTBO_ARTEFACTS = "\
    "

ROOTFS_ARTEFACTS = "rootfs.ext4.xz"

BOOTLOADER_ARTEFACTS = "\
    SPL-sd \
    SPL-nand \
    u-boot.img-nand \
    u-boot.img-sd \
    fw_env.config \
    "

# Anything that is not mentioned above but it is created during updater artifacts creation e.g.
# default DTB symlinks etc.
EXTRA_ARTEFACTS = "imx6ul-var-dart-6ulcustomboard-nand-wifi-imx6ul-var-dart.dtb"

UPDATE_IMAGES = "version.txt ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${DTBO_ARTEFACTS} ${ROOTFS_ARTEFACTS} ${EXTRA_ARTEFACTS}"

do_updater() {
        echo "IMG_VERSION = ${IMG_VERSION}"
        rm -rf ${TOPDIR}/deploy/${MACHINE}
        install -d ${TOPDIR}/deploy/${MACHINE}
        OLDPWD="$PWD"
        cd ${TOPDIR}/deploy/${MACHINE}
        echo "${IMG_VERSION}" > version.txt
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}.ext4.xz ${ROOTFS_ARTEFACTS}
        for f in ${KERNEL_ARTEFACTS} ${BOOTLOADER_ARTEFACTS}
        do
            install ${DEPLOY_DIR_IMAGE}/$f $f
        done
        #default device tree file One of the dtbs from BOOTLOADER_ARTEFACTS here we choose 'wifi with nand' one
        install imx6ul-var-dart-6ulcustomboard-nand-wifi.dtb imx6ul-var-dart-6ulcustomboard-nand-wifi-imx6ul-var-dart.dtb

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
        install ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd ${DEPLOY_DIR_IMAGE}/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        cd ${OLDPWD}
        rm -rf ${TOPDIR}/deploy/${MACHINE}
}
