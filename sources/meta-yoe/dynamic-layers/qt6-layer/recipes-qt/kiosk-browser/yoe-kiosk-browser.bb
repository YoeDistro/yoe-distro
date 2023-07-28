SUMMARY = "Yoe Kiosk Browser"
DESCRIPTION = "A web browser designed for embedded systems"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

SRC_URI = "git://github.com/YoeDistro/yoe-kiosk-browser;branch=main;protocol=https"
SRCREV = "ce1b54c23511b563829b91dbf4fbbe03e49d424b"

PV = "1.0.0+git${SRCPV}"

S = "${WORKDIR}/git"

inherit cmake qt6-cmake systemd

DEPENDS += "qtbase qtwebview qtdeclarative qtdeclarative-native"

INITSCRIPT_NAME = "yoe-kiosk-browser"
INITSCRIPT_PARAMS = "start 99 5 . stop 20 6 ."

# You can override the following settings in site.conf, etc.
# Default to Simple IoT. 
YOE_KIOSK_BROWSER_URL ?= "http://localhost:8118"
# Currently, values of 0, 90, and 270 are supported
YOE_KIOSK_BROWSER_ROTATE ?= "0"
# the following scale should be <= 1
YOE_KIOSK_BROWSER_KEYBOARD_SCALE ?= "1"

do_install:append() {
    echo "Browser URL: ${YOE_KIOSK_BROWSER_URL}"
    if ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'true', 'false', d)}; then
        install -D -m 0644 ${S}/yoe-kiosk-browser-wayland.service ${D}${systemd_unitdir}/system/yoe-kiosk-browser.service
    else
        install -D -m 0644 ${S}/yoe-kiosk-browser-eglfs.service ${D}${systemd_unitdir}/system/yoe-kiosk-browser.service
        install -D -m 0644 ${S}/eglfs.json ${D}${sysconfdir}/default/eglfs.json
    fi

    install -D -m 0644 ${S}/yoe-kiosk-browser-env ${D}${sysconfdir}/default/yoe-kiosk-browser

    # fill in service template values
    sed -i "s|@URL@|${YOE_KIOSK_BROWSER_URL}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@ROTATE@|${YOE_KIOSK_BROWSER_ROTATE}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@KEYBOARD_SCALE@|${YOE_KIOSK_BROWSER_KEYBOARD_SCALE}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser
}

SYSTEMD_SERVICE:${PN} = "yoe-kiosk-browser.service"

FILES:${PN} += "${sysconfdir}/default"
