FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install:append:ti33x() {
    sed -i '/\[core\]/a gbm-format=rgb565' ${D}${sysconfdir}/xdg/weston/weston.ini
}
