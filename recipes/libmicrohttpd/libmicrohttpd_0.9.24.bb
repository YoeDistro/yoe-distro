DESCRIPTION = "GNU libmicrohttpd is a small C library that is supposed to make it easy to run an HTTP server as part of another application."
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://COPYING;md5=9331186f4f80db7da0e724bdd6554ee5"

DEPENDS = "libgcrypt curl"

SRC_URI = "ftp://ftp.nluug.nl/pub/gnu/libmicrohttpd//libmicrohttpd-${PV}.tar.gz"
SRC_URI[md5sum] = "2891c82cc85a92e6944cacf9ae413f7c"
SRC_URI[sha256sum] = "d04cf7796e0b9e2845432d266712992840937e5975ed45f51f89ccc50d53e232"

inherit autotools lib_package

do_compile_append() {
	sed -i s:-L${STAGING_LIBDIR}::g libmicrohttpd.pc
}
