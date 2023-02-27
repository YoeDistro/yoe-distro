FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://rc.pvr.service \
            file://0001-Add-GL-and-GLES3-headers.patch \
           "

inherit systemd

do_install:append() {
    rm -rf ${D}${libdir}/libGLESv2.so.1
    ln -sf libGLESv2.so.2 ${D}${libdir}/libGLESv2.so.1
    if [ ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)} ]; then
        if [-e ${D}${sysconfdir}/init.d/rc.pvr]; then
            mv ${D}${sysconfdir}/init.d/rc.pvr ${D}${bindir}
            rmdir ${D}${sysconfdir}/init.d ${D}${sysconfdir}
        else
            install -Dm0755 ${S}/targetfs/common/etc/init.d/rc.pvr ${D}${bindir}/rc.pvr
        fi
        install -Dm 644 ${WORKDIR}/rc.pvr.service ${D}/${systemd_unitdir}/system/rc.pvr.service
    fi
}

SYSTEMD_SERVICE:${PN} = "rc.pvr.service"
