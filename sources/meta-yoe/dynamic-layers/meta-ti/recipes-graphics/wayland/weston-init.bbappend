FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_install:append:ti33x() {
    sed -i '/\[core\]/a gbm-format=rgb565' ${D}${sysconfdir}/xdg/weston/weston.ini
    if [ -e ${D}/${sysconfdir}/init.d/weston ]; then
        sed -i 's#weston-start --#weston-start -- --continue-without-input#' ${D}/${sysconfdir}/init.d/weston
    fi
    if [ -e ${D}${systemd_system_unitdir}/weston.service ]; then
        sed -i 's#ExecStart=/usr/bin/weston#ExecStart=/usr/bin/weston --continue-without-input#' ${D}${systemd_system_unitdir}/weston.service
    fi
}
