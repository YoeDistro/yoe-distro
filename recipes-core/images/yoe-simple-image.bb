# Yoe sample image

require recipes-core/images/core-image-base.bb
require updater.inc

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit features_check

IMAGE_FEATURES += "ssh-server-dropbear package-management hwcodecs"

IMAGE_INSTALL += "\
    os-release \
"

IMAGE_INSTALL_append_arm = " 96boards-tools"
IMAGE_INSTALL_append_aarch64 = " 96boards-tools"

export IMAGE_BASENAME = "yoe-simple-image"

BAD_RECOMMENDATIONS += "eudev-hwdb"
