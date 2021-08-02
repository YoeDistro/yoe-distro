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
SWUPDATE_IMAGES:append_odroid-c4-hardkernel = " \
    Image.gz-initramfs \
    u-boot \
    boot \
    config \
    meson64_odroidc4 \
    ads7846 \
    can0 \
    esp8089 \
    fanspeed-full \
    hifishield2 \
    hifishield \
    hktft32 \
    hktft35 \
    i2c0 \
    i2c1 \
    lineout \
    onewire \
    pcf8563 \
    pwm_ab \
    pwm_a-pwmfan \
    pwm_b-backlight \
    pwm_cd \
    pwm_ef \
    sdio \
    spi0 \
    sx865x-i2c1 \
    uart0 \
    uart1 \
    uart2 \
"

# a deployable image can have multiple format, choose one
SWUPDATE_IMAGES_FSTYPES[yoe-simple-image] = ".ext4.gz"
SWUPDATE_IMAGES_FSTYPES[Image.gz-initramfs] = ".bin"
SWUPDATE_IMAGES_FSTYPES[u-boot] = ".bin"
SWUPDATE_IMAGES_FSTYPES[boot] = ".ini"
SWUPDATE_IMAGES_FSTYPES[config] = ".ini"

SWUPDATE_IMAGES_FSTYPES[meson64_odroidc4] = ".dtb"
SWUPDATE_IMAGES_FSTYPES[ads7846] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[can0] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[esp8089] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[fanspeed-full] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[hifishield2] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[hifishield] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[hktft32] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[hktft35] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[i2c0] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[i2c1] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[lineout] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[onewire] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[pcf8563] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[pwm_ab] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[pwm_a-pwmfan] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[pwm_b-backlight] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[pwm_cd] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[pwm_ef] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[sdio] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[spi0] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[sx865x-i2c1] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[uart0] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[uart1] = ".dtbo"
SWUPDATE_IMAGES_FSTYPES[uart2] = ".dtbo"


SWUPDATE_IMAGES_NOAPPEND_MACHINE[meson64_odroidc4] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[ads7846] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[can0] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[esp8089] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[fanspeed-full] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[hifishield2] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[hifishield] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[hktft32] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[hktft35] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[i2c0] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[i2c1] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[lineout] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[onewire] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[pcf8563] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[pwm_ab] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[pwm_a-pwmfan] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[pwm_b-backlight] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[pwm_cd] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[pwm_ef] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[sdio] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[spi0] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[sx865x-i2c1] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[uart0] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[uart1] = "1"
SWUPDATE_IMAGES_NOAPPEND_MACHINE[uart2] = "1"
