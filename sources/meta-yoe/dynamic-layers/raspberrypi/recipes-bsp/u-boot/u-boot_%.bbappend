FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_rpi = " file://0001-enables-larger-kernel-images.patch "
