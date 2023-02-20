# We use updater to handle disk/SD management, therefore remove 96boards-tools
IMAGE_INSTALL:remove = "96boards-tools"

UPDATE_IMAGES ?= "\
        version.txt \
        u-boot.bin \
        uboot.env \
        BOOT.BIN \
        sama5d27_som1_ek.itb \
        rootfs.ext4.xz \
"

do_updater () {
        echo "IMG_VERSION = ${IMG_VERSION}"
        rm -rf ${TOPDIR}/deploy/${MACHINE}
        install -d ${TOPDIR}/deploy/${MACHINE}
        cd ${TOPDIR}/deploy/${MACHINE}
        echo "${IMG_VERSION}" > version.txt
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.ext4.xz rootfs.ext4.xz
        #install ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGE} zImage
        install ${DEPLOY_DIR_IMAGE}/sama5d27_som1_ek.itb sama5d27_som1_ek.itb
        install ${DEPLOY_DIR_IMAGE}/BOOT.BIN BOOT.BIN
        install ${DEPLOY_DIR_IMAGE}/u-boot.bin u-boot.bin
        install ${DEPLOY_DIR_IMAGE}/uboot.env uboot.env
        sha256sum ${UPDATE_IMAGES}  > update.sha256
        rm -rf ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        ls ${UPDATE_IMAGES_} | cpio -ov -H newc > ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        install ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd ${DEPLOY_DIR_IMAGE}/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        cd ${OLDPWD}
        rm -rf ${TOPDIR}/deploy/${MACHINE}
}
