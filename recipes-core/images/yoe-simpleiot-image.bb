# Yoe sample IoT image

require recipes-core/images/core-image-minimal.bb
require updater.inc

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit features_check

IMAGE_FEATURES += "ssh-server-dropbear"

IMAGE_INSTALL += "\
    os-release \
"
export IMAGE_BASENAME = "yoe-simpleiot-image"

BAD_RECOMMENDATIONS += "eudev-hwdb udev-hwdb"
