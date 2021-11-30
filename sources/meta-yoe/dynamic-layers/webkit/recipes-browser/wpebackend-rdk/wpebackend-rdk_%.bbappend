FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Enable rpi backend
PACKAGECONFIG:append:rpi = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '', ' rpi', d)}"
