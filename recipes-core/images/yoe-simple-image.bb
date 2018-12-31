# Yoe sample image

require recipes-core/images/core-image-base.bb
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit distro_features_check

IMAGE_FEATURES += "ssh-server-dropbear package-management hwcodecs"

IMAGE_INSTALL += "\
    os-release \
"

export IMAGE_BASENAME = "yoe-simple-image"
