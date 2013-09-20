DESCRIPTION = "Network Hotplug"
LICENSE = "CLOSED"

PR = "r2"

SRC_URI = " \
           file://network@.service \
           file://network.rules \
          "

FILES_${PN} = "${sysconfdir}/udev/rules.d/* ${base_libdir}/systemd/system/*"
RDEPENDS_${PN} = "udev"

do_install() {
    install -d ${D}${base_libdir}/systemd/system/basic.target.wants
    install -m 0644 ${WORKDIR}/*.service ${D}${base_libdir}/systemd/system
    
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/network.rules     ${D}${sysconfdir}/udev/rules.d/network.rules
}

