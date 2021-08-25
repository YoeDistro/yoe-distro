FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append_rpi = " file://0001-enables-larger-kernel-images.patch "
