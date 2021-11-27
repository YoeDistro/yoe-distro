FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG:append = " ${@bb.utils.contains('MACHINE_FEATURES', 'gpu', 'egl glesv2', '', d)}"
