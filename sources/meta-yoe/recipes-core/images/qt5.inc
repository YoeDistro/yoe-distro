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
        ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'qtwayland-plugins', '', d)} \
"
QTWEBKIT ??= "\
	qtwebkit \
	qtwebkit-qmlplugins \
"

CORE_IMAGE_EXTRA_INSTALL += " \
  ${QT5APPS} \
  ${QT5BASE} \
"
