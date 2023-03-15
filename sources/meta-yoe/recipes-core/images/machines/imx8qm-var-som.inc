# We use updater to handle disk/SD management, therefore remove 96boards-tools
IMAGE_INSTALL:remove = "96boards-tools"

KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

KERNEL_ARTEFACTS = "\
    ${KERNEL_IMAGETYPE} \
    imx8qm-var-som-symphony-dp-m4.dtb \
    imx8qm-var-som-symphony-dp.dtb \
    imx8qm-var-som-symphony-hdmi-m4.dtb \
    imx8qm-var-som-symphony-hdmi.dtb \
    imx8qm-var-som-symphony-lvds.dtb \
    imx8qm-var-som-symphony-lvds-m4.dtb \
    "
DTBO_ARTEFACTS = "\
    "

ROOTFS_ARTEFACTS = "rootfs.ext4.xz"

BOOTLOADER_ARTEFACTS = "\
    imx-boot \
    dpfw.bin \
    hdmirxfw.bin \
    hdmitxfw.bin \
    "
UPDATE_IMAGES = "version.txt ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${DTBO_ARTEFACTS} ${ROOTFS_ARTEFACTS}"

do_updater() {
        echo "IMG_VERSION = ${IMG_VERSION}"
        rm -rf ${TOPDIR}/deploy/${MACHINE}
        install -d ${TOPDIR}/deploy/${MACHINE}
        OLDPWD="$PWD"
        cd ${TOPDIR}/deploy/${MACHINE}
        echo "${IMG_VERSION}" > version.txt
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.ext4.xz ${ROOTFS_ARTEFACTS}
        for f in ${KERNEL_ARTEFACTS} ${BOOTLOADER_ARTEFACTS}
        do
            install ${DEPLOY_DIR_IMAGE}/$f $f
        done
        #default device tree file One of the dtbs from BOOTLOADER_ARTEFACTS here we choose 'lvds' one
        install imx8qm-var-som-symphony-lvds.dtb imx8qm-var-som-symphony.dtb

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
