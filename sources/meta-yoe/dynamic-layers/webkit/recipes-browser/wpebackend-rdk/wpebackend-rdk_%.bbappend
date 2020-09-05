FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Enable rpi backend
PACKAGECONFIG_append_rpi = "${@bb.utils.contains('MACHINE_FEATURES', 'vc4graphics', '', ' rpi', d)}"
