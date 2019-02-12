# Yoe sample image

require recipes-core/images/core-image-base.bb
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "coreutils-native"

inherit distro_features_check

IMAGE_FEATURES += "ssh-server-dropbear package-management hwcodecs"

IMAGE_INSTALL += "\
    os-release \
"

IMAGE_INSTALL_append_arm = " 96boards-tools"
IMAGE_INSTALL_append_aarch64 = " 96boards-tools"

export IMAGE_BASENAME = "yoe-simple-image"

UPDATE_IMAGES_ ??= ""

UPDATE_IMAGES_sama5d27-som1-ek-sd ?= "\
        version.txt \
        u-boot.bin \
        BOOT.BIN \
        zImage \
        at91-sama5d27_som1_ek.dtb \
        rootfs.tar.xz \
"

UPDATE_IMAGES_ ?= "${UPDATE_IMAGES} update.sha256"
KERNEL_IMAGE ?= "zImage-initramfs-${MACHINE}.bin"

IMG_VERSION ?= "0.0.0"

do_updater () {
}

do_updater_append_sama5d27-som1-ek-sd () {
        echo "IMG_VERSION = ${IMG_VERSION}"
        install -d ${TOPDIR}/images
        cd ${TOPDIR}/images
        echo "${IMG_VERSION}" > version.txt
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.wic.xz ${MACHINE}_${IMG_VERSION}.wic.xz
        install ${DEPLOY_DIR_IMAGE}/${IMAGE_BASENAME}-${MACHINE}.tar.xz rootfs.tar.xz
        install ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGE} zImage
        install ${DEPLOY_DIR_IMAGE}/at91-sama5d27_som1_ek.dtb at91-sama5d27_som1_ek.dtb
        install ${DEPLOY_DIR_IMAGE}/BOOT.BIN BOOT.BIN
        install ${DEPLOY_DIR_IMAGE}/u-boot.bin u-boot.bin
        sha256sum ${UPDATE_IMAGES}  > update.sha256
        tar -cf ${MACHINE}_${IMG_VERSION}.upd ${UPDATE_IMAGES_}
        rm -rf ${UPDATE_IMAGES_}
}

addtask updater after do_image before do_build
do_updater[depends] += "${PN}:do_image_complete"
do_updater[depends] += "virtual/kernel:do_deploy"
# We want to build updater everytime we build image
do_updater[nostamp] = "1"
