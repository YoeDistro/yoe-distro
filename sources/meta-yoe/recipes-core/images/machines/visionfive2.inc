# We use updater to handle disk/SD management, therefore remove 96boards-tools
IMAGE_INSTALL:remove = "96boards-tools"

KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

KERNEL_ARTEFACTS = "\
    ${KERNEL_IMAGETYPE} \
    jh7110-starfive-visionfive-2-v1.3b.dtb \
    "
DTBO_ARTEFACTS = "\
    "

ROOTFS_ARTEFACTS = "rootfs.ext4.xz"

BOOTLOADER_ARTEFACTS = "\
    EFI/BOOT/bootriscv64.efi \
    "

# Anything that is not mentioned above but it is created during updater artifacts creation e.g.
# default DTB symlinks etc.
EXTRA_ARTEFACTS = ""

UPDATE_IMAGES = "version.txt ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${DTBO_ARTEFACTS} ${ROOTFS_ARTEFACTS} ${EXTRA_ARTEFACTS}"

do_updater() {
        echo "IMG_VERSION = ${IMG_VERSION}"
        rm -rf ${TOPDIR}/deploy/${MACHINE}
        install -d ${TOPDIR}/deploy/${MACHINE}
        OLDPWD="$PWD"
        cd ${TOPDIR}/deploy/${MACHINE}
        echo "${IMG_VERSION}" > version.txt
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_LINK_NAME}.ext4.xz ${ROOTFS_ARTEFACTS}
        for f in ${KERNEL_ARTEFACTS}
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
        # install EFI bootloader in final location as in target
        mkdir -p EFI/BOOT
        install ${DEPLOY_DIR_IMAGE}/grub-efi-bootriscv64.efi EFI/BOOT/bootriscv64.efi
        sha256sum ${UPDATE_IMAGES}  > update.sha256
        rm -rf ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        ls ${UPDATE_IMAGES_} | cpio -ov -H newc > ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        install ${TOPDIR}/deploy/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd ${DEPLOY_DIR_IMAGE}/${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd
        cd ${OLDPWD}
        rm -rf ${TOPDIR}/deploy/${MACHINE}
}
