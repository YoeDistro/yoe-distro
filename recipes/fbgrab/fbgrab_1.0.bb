SECTION = "console/network"
DESCRIPTION = "framebuffer screenshot program"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=ea5bed2f60d357618ca161ad539f7c0a"

PR = "r2"

DEPENDS = " zlib libpng "

SRC_URI = "http://hem.bredband.net/gmogmo/fbgrab/fbgrab-${PV}.tar.gz;name=archive \
           file://makefile.patch \
	   http://people.openezx.org/ao2/fbgrab_network_mode.diff;name=patch \
	   file://fbgrab_1bpp.patch \
	   "

do_install() {
	install -d ${D}${bindir} ${D}${mandir}/man1/
	install -m 0755 fbgrab ${D}${bindir}
	install -m 0644 fbgrab.1.man ${D}${mandir}/man1/fbgrab.1
}

SRC_URI[archive.md5sum] = "7af4d8774684182ed690d5da82d6d234"
SRC_URI[archive.sha256sum] = "9158241a20978dcc4caf0692684da9dd3640fd6f5c8b72581bd099198d670510"
SRC_URI[patch.md5sum] = "71bf1218c52a6e4a1f38406748285255"
SRC_URI[patch.sha256sum] = "e8cf4fe15d7e99e86016db3ddc1f403c35c49f40c4d37209d76cd5785c541aa8"
