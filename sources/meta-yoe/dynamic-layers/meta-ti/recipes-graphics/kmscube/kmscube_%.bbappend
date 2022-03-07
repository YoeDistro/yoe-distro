FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRCREV:ti-soc = "76bb57d539cb43d267e561024c34e031bf351e04"
SRC_URI:append:ti-soc = " file://0001-meson-check-for-gles3-support.patch"

CFLAGS += "-fcommon"

