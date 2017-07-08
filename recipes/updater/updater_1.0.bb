DESCRIPTION = "Application Updater"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Proprietary;md5=0557f9d92cf58f2ccdd50f62f8ac0b28"

SRC_URI = "file://init"

do_install() {
    install -m 775 ${WORKDIR}/init ${D}/init
}

FILES_${PN} += "/init"

