FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "\
    file://0001-Consider-OE-toolchain-tuples-as-armhf.patch \
    file://0001-Fix-driver-config-for-5.10-kernel.patch \
"
