DESCRIPTION = "System Updater"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

S = "${UNPACKDIR}"
   
SRC_URI = "file://init \
           file://platform \
           "
do_configure() {
    :
}
do_compile() {
    :
}
do_install() {
    install -Dm 0775 ${UNPACKDIR}/init ${D}/init
    install -Dm 0664 ${UNPACKDIR}/platform ${D}/platform
    install -d ${D}/dev
    mknod -m 622 ${D}/dev/console c 5 1
}

FILES:${PN} += "/init /platform /dev ${datadir}"

RDEPENDS:${PN} += "e2fsprogs-resize2fs util-linux-sfdisk"

