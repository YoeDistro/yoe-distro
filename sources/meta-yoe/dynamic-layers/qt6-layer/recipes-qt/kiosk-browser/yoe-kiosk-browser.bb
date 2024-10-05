SUMMARY = "Yoe Kiosk Browser"
DESCRIPTION = "A web browser designed for embedded systems"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

SRC_URI = "git://github.com/YoeDistro/yoe-kiosk-browser;branch=main;protocol=https"
SRCREV = "47846c7a62aea8317070f4a79b80cd26ded74bdd"

PV = "1.0.0+git"

S = "${WORKDIR}/git"

inherit cmake qt6-cmake systemd

DEPENDS += "qtbase qtwebview qtdeclarative qtdeclarative-native"

RDEPENDS:${PN} += "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'qtwayland', '', d)}"
RDEPENDS:${PN} += "qtvirtualkeyboard"

INITSCRIPT_NAME = "yoe-kiosk-browser"
INITSCRIPT_PARAMS = "start 99 5 . stop 20 6 ."

# You can override the following settings in site.conf, etc.
# Default to Simple IoT. 
YOE_KIOSK_BROWSER_URL ?= "http://localhost:8118"

# Currently, values of 0, 90, and 270 are supported
YOE_KIOSK_BROWSER_ROTATE ?= "0"

# the following scale should be <= 1
YOE_KIOSK_BROWSER_KEYBOARD_SCALE ?= "1"

# start full screen
YOE_KIOSK_BROWSER_FULLSCREEN ?= "1"

# If you have no trouble with default dialogs, enable them here
YOE_KIOSK_BROWSER_DEFAULT_DIALOGS ?= "0"
YOE_KIOSK_BROWSER_DIALOG_COLOR ?= "#D91824"

# On some touchscreens the first input of a touch event wont activate the 
# correct focus. This quirk solves this issue.
YOE_KIOSK_BROWSER_TOUCH_QUIRK ?= "1"

# the following is the interval at which we try
# to reload a failed web page (seconds)
# default is 5s if not specified.
YOE_KIOSK_BROWSER_RETRY_INTERVAL = "10"

# the following is typically a local web page that is loaded
# instead of the default error screen.
# If this is not set, the default error screen is shown.
YOE_KIOSK_BROWSER_EXCEPTION_URL=""

# In case you use your own trusted https webserver on your local browser
# you can ignore the certification errors.
YOE_KIOSK_BROWSER_IGNORE_CERT_ERR ?= "1"

# Running the browser in root will require disabled sandbox mode
QTWEBENGINE_DISABLE_SANDBOX ?= "1"

# Depending upon screen attached to system
SCREEN_RESOLUTION ?= "1024x600"

# DRI card number, may vary for different boards
DISPLAY_CARD ?= "/dev/dri/card0"
# Define it via a knob which can be set from config file e.g. local.conf
YOE_KIOSK_BROWSER_SYSTEMD_UNIT ?= "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'yoe-kiosk-browser-wayland.service', 'yoe-kiosk-browser-eglfs.service', d)}"

do_install:append() {
    echo "Browser URL: ${YOE_KIOSK_BROWSER_URL}"
    install -D -m 0644 ${S}/${YOE_KIOSK_BROWSER_SYSTEMD_UNIT} ${D}${systemd_unitdir}/system/yoe-kiosk-browser.service
    install -D -m 0644 ${S}/eglfs.json ${D}${sysconfdir}/default/eglfs.json
    install -D -m 0644 ${S}/yoe-kiosk-browser-env ${D}${sysconfdir}/default/yoe-kiosk-browser

    # fill in service template values
    sed -i "s|@URL@|${YOE_KIOSK_BROWSER_URL}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@ROTATE@|${YOE_KIOSK_BROWSER_ROTATE}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@KEYBOARD_SCALE@|${YOE_KIOSK_BROWSER_KEYBOARD_SCALE}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@FULLSCREEN@|${YOE_KIOSK_BROWSER_FULLSCREEN}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@DEFAULT_DIALOGS@|${YOE_KIOSK_BROWSER_DEFAULT_DIALOGS}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@DIALOG_COLOR@|${YOE_KIOSK_BROWSER_DIALOG_COLOR}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@TOUCH_QUIRK@|${YOE_KIOSK_BROWSER_TOUCH_QUIRK}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@RETRY_INTERVAL@|${YOE_KIOSK_BROWSER_RETRY_INTERVAL}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@EXCEPTION_URL@|${YOE_KIOSK_BROWSER_EXCEPTION_URL}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@IGNORE_CERT_ERR@|${YOE_KIOSK_BROWSER_IGNORE_CERT_ERR}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@DISABLE_SANDBOX@|${QTWEBENGINE_DISABLE_SANDBOX}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@@|${YOE_KIOSK_BROWSER_KEYBOARD_SCALE}|" \
        ${D}${sysconfdir}/default/yoe-kiosk-browser

    sed -i "s|@RESOLUTION@|${SCREEN_RESOLUTION}|" \
        ${D}${sysconfdir}/default/eglfs.json

    sed -i "s|@DISPLAY_CARD@|${DISPLAY_CARD}|" \
        ${D}${sysconfdir}/default/eglfs.json

    if [ "${YOE_KIOSK_BROWSER_XCB}" = "1" ]; then
        echo "DISPLAY=:0" >> ${D}${sysconfdir}/default/yoe-kiosk-browser
        echo "XAUTHORITY=/home/root/.Xauthority" >> ${D}${sysconfdir}/default/yoe-kiosk-browser
        echo "QT_QPA_PLATFORM=xcb" >> ${D}${sysconfdir}/default/yoe-kiosk-browser
    fi
}

SYSTEMD_SERVICE:${PN} = "yoe-kiosk-browser.service"

FILES:${PN} += "${sysconfdir}/default"

# Keep in sync with meta-qt6/recipes-qt/qt6/chromium-gn.inc
COMPATIBLE_MACHINE = "(-)"
COMPATIBLE_MACHINE:aarch64 = "(.*)"
COMPATIBLE_MACHINE:armv6 = "(.*)"
COMPATIBLE_MACHINE:armv7a = "(.*)"
COMPATIBLE_MACHINE:armv7ve = "(.*)"
COMPATIBLE_MACHINE:x86-64 = "(.*)"
