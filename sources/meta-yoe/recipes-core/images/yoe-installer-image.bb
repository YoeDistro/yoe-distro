# Yoe factory image

require recipes-core/images/core-image-minimal.bb
include recipes-core/images/updater.inc

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

export IMAGE_BASENAME = "yoe-installer-image"

IMAGE_FSTYPES = "wic.bmap wic.xz"

# Do not pollute the installer image with full image features
IMAGE_FEATURES = "ssh-server-openssh hwcodecs debug-tweaks"

PACKAGE_INSTALL = "\
    packagegroup-core-boot \
    packagegroup-core-ssh-openssh \
    ${MACHINE_HWCODECS} \
"

FACTORY_INSTALL_IMAGE ?= "yoe-simple-image"
do_image_wic[depends] += "${@bb.utils.contains('IMAGE_CLASSES', 'qemuboot', '', '${FACTORY_INSTALL_IMAGE}:do_updater' ,d)}"

do_create_updater_env() {
    cat >${DEPLOY_DIR_IMAGE}/yoe-updater.env <<_EOF
YOE_UPDATER_MODE=factory
_EOF
}

addtask create_updater_env before do_image_wic

do_updater() {
    install ${DEPLOY_DIR_IMAGE}/yoe-installer-image-${MACHINE}.wic.xz ${TOPDIR}/deploy/${MACHINE}_${IMG_VERSION}.wic.xz
    install ${DEPLOY_DIR_IMAGE}/yoe-installer-image-${MACHINE}.wic.bmap ${TOPDIR}/deploy/${MACHINE}_${IMG_VERSION}.wic.bmap
}

IMAGE_INSTALL:remove = " kernel-devicetree kernel-image-${KERNEL_IMAGETYPE}"

IMAGE_BOOT_FILES += "${UPDATE_IMAGE_NAME}_${IMG_VERSION}.upd yoe-updater.env"
