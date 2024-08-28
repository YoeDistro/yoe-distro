FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "\
    file://systemd.cfg \
    file://hash.cfg \
    file://part-format.cfg \
    file://archive.cfg \
    file://disable-uboot.cfg \
"

DEPENDS += "e2fsprogs"

do_install:append() {
    rm -rf ${D}${sysconfdir}/swupdate.cfg
}

RDEPENDS:${PN} += "swupdate-machine-config"
FILES_${PN}:remove = "${sysconfdir}/swupdate.cfg"
