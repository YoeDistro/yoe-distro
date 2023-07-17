SUMMARY = "Yoe Kiosk Browser"
DESCRIPTION = "A web browser designed for embedded systems"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

SRC_URI = "git://github.com/YoeDistro/yoe-kiosk-browser;branch=main;protocol=https"
SRCREV = "86084ea2fb67ddb83c1508f24abaabc578a9e6d8"

PV = "1.0.0+git${SRCPV}"

S = "${WORKDIR}/git"

inherit cmake qt6-cmake systemd

DEPENDS += "qtbase qtwebview qtdeclarative qtdeclarative-native"

INITSCRIPT_NAME = "yoe-kiosk-browser"
INITSCRIPT_PARAMS = "start 99 5 . stop 20 6 ."

do_install:append() {
    install -D -m 0644 ${S}/yoe-kiosk-browser.service ${D}${systemd_unitdir}/system/yoe-kiosk-browser.service
}

SYSTEMD_SERVICE:${PN} = "yoe-kiosk-browser.service"
