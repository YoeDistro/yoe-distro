FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://wireguard.cfg"

KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/wireguard.cfg"
