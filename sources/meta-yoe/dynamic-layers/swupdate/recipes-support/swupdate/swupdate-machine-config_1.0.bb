DESCRIPTION = "Machine-specific configuration for swupdate"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://swupdate.cfg.in \
    file://swupdate-genconfig.sh \
    file://swupdate-mods.conf \
"

SRC_URI:append:secureboot = " \
    file://swupdate.pem \
"

SWUPDATE_BOARDNAME ??= "${MACHINE}"
SWUPDATE_HWREVISION ??= "1.0"

S = "${WORKDIR}/sources"
UNPACKDIR = "${S}"
B = "${WORKDIR}/build"

do_compile() {
    rm -f ${B}/hwrevision
    echo "${SWUPDATE_BOARDNAME} ${SWUPDATE_HWREVISION}" > ${B}/hwrevision
    sed -e's,@MODEL@,${SWUPDATE_BOARDNAME},g' \
	${S}/swupdate.cfg.in > ${B}/swupdate.cfg.in
}

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${B}/hwrevision ${D}${sysconfdir}/
    ln -s /run/swupdate/swupdate.cfg ${D}${sysconfdir}/swupdate.cfg
    install -d ${D}${datadir}/swupdate
    install -m 0644 ${B}/swupdate.cfg.in ${D}${datadir}/swupdate/
    install -d ${D}${libexecdir}/swupdate
    install -m 0755 ${S}/swupdate-genconfig.sh ${D}${libexecdir}/swupdate/swupdate-genconfig
    install -d ${D}${sysconfdir}/systemd/system/swupdate.service.d
    install -m 0644 ${S}/swupdate-mods.conf ${D}${sysconfdir}/systemd/system/swupdate.service.d/
}

do_install:append:secureboot() {
    install -m 0644 ${S}/swupdate.pem ${D}${datadir}/swupdate/
}

FILES:${PN} += "${datadir}/swupdate"
PACKAGE_ARCH = "${MACHINE_ARCH}"
EXTRADEPS = "tegra-redundant-boot"
RDEPENDS:${PN} += "${EXTRADEPS}"
