KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

IMAGE_INSTALL_remove = "kernel-image-${KERNEL_IMAGETYPE} \
                        kernel-image-image kernel-image \
                        kernel-devicetree \
                        "
IMAGE_BOOT_FILES = "${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS}"

KERNEL_ARTEFACTS = "\
    ${KERNEL_IMAGETYPE} \
    am335x-bone.dtb \
    am335x-boneblack-wireless.dtb \
    am335x-boneblack.dtb \
    am335x-boneblue.dtb \
    am335x-bonegreen-wireless.dtb \
    am335x-bonegreen.dtb \
    "

ROOTFS_ARTEFACTS = "rootfs.tar.xz"

BOOTLOADER_ARTEFACTS = "\
    ${SPL_BINARY} \
    u-boot.${UBOOT_SUFFIX} \
    "
UPDATE_IMAGES = "version.txt ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${ROOTFS_ARTEFACTS}"

do_updater() {
        echo "IMG_VERSION = ${IMG_VERSION}"
        rm -rf ${TOPDIR}/deploy/${MACHINE}
        install -d ${TOPDIR}/deploy/${MACHINE}
        OLDPWD="$PWD"
        cd ${TOPDIR}/deploy/${MACHINE}
        echo "${IMG_VERSION}" > version.txt
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
        install ${DEPLOY_DIR_IMAGE}/yoe-installer-image-${MACHINE}.wic.xz ${TOPDIR}/deploy/${MACHINE}_${IMG_VERSION}.wic.xz
        install ${DEPLOY_DIR_IMAGE}/yoe-installer-image-${MACHINE}.wic.bmap ${TOPDIR}/deploy/${MACHINE}_${IMG_VERSION}.wic.bmap
        cd ${OLDPWD}
        rm -rf ${TOPDIR}/deploy/${MACHINE}
}

