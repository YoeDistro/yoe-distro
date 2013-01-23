DESCRIPTION = "Viewer for a network enabled fbgrab"
HOMEPAGE = "http://svn.openezx.org/trunk/src/userspace/fbgrab/"
LICENSE = "GPL"
SECTION = "console/network"
DEPENDS = "libpng-native"
SRCREV = "1943"
PV = "0.0+svn${SRCDATE}"
PR = "r30"

SRC_URI = "svn://svn.openezx.org/trunk/src/userspace;module=fbgrab;proto=http"
S = "${WORKDIR}/fbgrab"

inherit native

do_compile() {
	${CC} ${CFLAGS} ${LDFLAGS} -g -Wall -lpng -lX11 -o fbgrab-viewer fbgrab-viewer.c
}

do_deploy() {
	install -d ${DEPLOY_DIR_IMAGE}
	install -m 0755 fbgrab-viewer ${DEPLOY_DIR_IMAGE}/fbgrab-viewer
}

do_install() {
    :
}

addtask deploy before do_install after do_compile
