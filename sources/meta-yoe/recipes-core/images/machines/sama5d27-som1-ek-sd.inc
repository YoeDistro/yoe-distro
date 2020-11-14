UPDATE_IMAGES ?= "\
        version.txt \
        u-boot.bin \
        BOOT.BIN \
        zImage \
        at91-sama5d27_som1_ek.dtb \
        rootfs.tar.xz \
"

do_updater () {
        echo "IMG_VERSION = ${IMG_VERSION}"
        install -d ${TOPDIR}/deploy
        cd ${TOPDIR}/deploy
        echo "${IMG_VERSION}" > version.txt
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.wic.xz ${MACHINE}_${IMG_VERSION}.wic.xz
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.tar.xz rootfs.tar.xz
        install ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGE} zImage
        install ${DEPLOY_DIR_IMAGE}/at91-sama5d27_som1_ek.dtb at91-sama5d27_som1_ek.dtb
        install ${DEPLOY_DIR_IMAGE}/BOOT.BIN BOOT.BIN
        install ${DEPLOY_DIR_IMAGE}/u-boot.bin u-boot.bin
        sha256sum ${UPDATE_IMAGES}  > update.sha256
        tar -cf ${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd ${UPDATE_IMAGES_}
        rm -rf ${UPDATE_IMAGES_}
}
