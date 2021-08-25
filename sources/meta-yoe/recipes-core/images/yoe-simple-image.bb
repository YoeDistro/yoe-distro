# Yoe starter image

DESCRIPTION = "Yoe Starter Image"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit core-image
require updater.inc

IMAGE_FEATURES += "ssh-server-dropbear package-management hwcodecs"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    packagegroup-base-wifi \
    packagegroup-base-zeroconf \
    packagegroup-distro-base \
    packagegroup-machine-base \
    packagegroup-base-ipv6 \
    os-release \
    ${CORE_IMAGE_EXTRA_INSTALL} \
"
IMAGE_INSTALL:append = "${@bb.utils.contains('INITRAMFS_IMAGE_BUNDLE', '1', '', ' 96boards-tools', d)}"

IMAGE_INSTALL:append:libc-musl = " gcompat"

export IMAGE_BASENAME = "yoe-simple-image"

BAD_RECOMMENDATIONS += "eudev-hwdb udev-hwdb libmodule-build-perl"
