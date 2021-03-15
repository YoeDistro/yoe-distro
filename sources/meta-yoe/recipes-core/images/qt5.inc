QT5APPS += " \
	cinematicexperience \
	qt5-demo-extrafiles \
	qt5everywheredemo \
	qt5nmapcarousedemo \
	qt5ledscreen \
	qt5nmapper \
	qtsmarthome \
	quitbattery \
	quitindicators \
"
QT5BASE = "\
	qtbase \
	qtbase-plugins \
	qtbase-tools \
	qtmultimedia \
	qtmultimedia-plugins \
	qtmultimedia-qmlplugins \
	qtsvg \
	qtsvg-plugins \
	qtsensors \
	qtsystems \
	qtsystems-tools \
	qtsystems-qmlplugins \
	qtscript \
	qtgraphicaleffects-qmlplugins \
	qtconnectivity-qmlplugins \
	qtlocation-plugins \
	qtlocation-qmlplugins \
	qtdeclarative \
	qtdeclarative-qmlplugins \
	qtdeclarative-plugins \
"
QTWEBKIT ??= "\
	qtwebkit \
	qtwebkit-qmlplugins \
"

inherit features_check

REQUIRED_DISTRO_FEATURES = "opengl"

X11BASE = "${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'x11-base', '', d)}"
IMAGE_FEATURES += "${@bb.utils.contains('DISTRO_FEATURES', 'wayland x11', '', '${X11BASE}', d)} \
                   ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston', '', d)} \
                  "

CORE_IMAGE_BASE_INSTALL += " \
  ${@bb.utils.contains('DISTRO_FEATURES', 'wayland x11', 'weston-xwayland', '', d)} \
  ${QT5APPS} \
  ${QT5BASE} \
"
# Ptest needs more RAM ( > 256M ) on QEMU
QB_MEM = "-m 1024"
