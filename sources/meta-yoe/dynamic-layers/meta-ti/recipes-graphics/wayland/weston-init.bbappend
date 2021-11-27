FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_configure:append:ti33x() {
    sed -i '/\[core\]/a gbm-format=rgb565' ${WORKDIR}/weston.ini
}
