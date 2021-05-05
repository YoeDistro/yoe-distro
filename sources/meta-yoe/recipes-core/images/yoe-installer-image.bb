# Yoe factory image

require recipes-core/images/core-image-minimal.bb
include machines/${MACHINE}.inc

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

export IMAGE_BASENAME = "yoe-installer-image"

IMAGE_FSTYPES = "wic.bmap wic.xz"

# Do not pollute the installer image with full image features
IMAGE_FEATURES = "ssh-server-dropbear hwcodecs debug-tweaks"

PACKAGE_INSTALL = "\
    packagegroup-core-boot \
    packagegroup-core-ssh-dropbear \
    ${MACHINE_HWCODECS} \
"

IMAGE_INSTALL_remove = " kernel-devicetree kernel-image-${KERNEL_IMAGETYPE}"
