# Copyright (C) 2020 Khem Raj <raj.khem@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "A Simple Software Update image"
HOMEPAGE = "https://yoedistro.org"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit swupdate

export IMAGE_BASENAME = "yoe-swupdate-image"

# Add all local files to be added to the SWU
# sw-description must always be in the list.
# You can extend with scripts or wahtever you need
SRC_URI = "\
    file://emmcsetup.lua \
    file://sw-description \
"
# images to build before building swupdate image
IMAGE_DEPENDS = "yoe-simple-image"

# images and files that will be included in the .swu image
SWUPDATE_IMAGES = "yoe-simple-image"
SWUPDATE_IMAGES_append_odroid-c4-hardkernel = " Image.gz-initramfs-${MACHINE}"

# a deployable image can have multiple format, choose one
SWUPDATE_IMAGES_FSTYPES[yoe-simple-image] = ".ext4.gz"
SWUPDATE_IMAGES_FSTYPES[Image.gz-initramfs-odroid-c4-hardkernel] = ".bin"

