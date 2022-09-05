FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Yoe supports wayland by default therefore add it if its in DISTRO_FEATURES
PACKAGECONFIG += "${@bb.utils.filter('DISTRO_FEATURES', 'wayland', d)}"
