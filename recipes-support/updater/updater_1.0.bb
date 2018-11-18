DESCRIPTION = "Application Updater"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Proprietary;md5=0557f9d92cf58f2ccdd50f62f8ac0b28"

# FIXME, need to add following based on package
#RDEPENDS_${PN} += "espeak"

SRC_URI = "file://init \
           file://platform \
           "

do_install() {
    install -m 775 ${WORKDIR}/init ${D}/init
    install -m 664 ${WORKDIR}/platform ${D}/platform
    install -d ${D}/dev
    mknod -m 622 ${D}/dev/console c 5 1
}

FILES_${PN} += "/init /platform /dev /usr/share/pw"
