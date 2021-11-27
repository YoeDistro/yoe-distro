FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:ti-soc = " file://0001-eglfs-Force-888-format-only-on-env-flag.patch"

QT_CONFIG_FLAGS:append:ti-soc = " -qpa eglfs"

PACKAGECONFIG_GL:ti-soc = "eglfs gles2 gbm"
PACKAGECONFIG_FONTS:ti-soc = "fontconfig"

PACKAGECONFIG:append:ti-soc = " libinput examples tslib xkbcommon kms"

PACKAGECONFIG:remove:ti-soc = "tests"


OE_QTBASE_EGLFS_DEVICE_INTEGRATION:ti-soc = "eglfs_kms"

do_configure:prepend:ti-soc() {
    # Add the appropriate EGLFS_DEVICE_INTEGRATION
    if [ "${@d.getVar('OE_QTBASE_EGLFS_DEVICE_INTEGRATION')}" != "" ]; then
        echo "EGLFS_DEVICE_INTEGRATION = ${OE_QTBASE_EGLFS_DEVICE_INTEGRATION}" >> ${S}/mkspecs/oe-device-extra.pri
    fi
}

RDEPENDS:${PN}:append:ti-soc = "${PN}-conf"
