# Yoe QT5/X11 sample image
require yoe-simple-image.bb

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

require qt5.inc

REQUIRED_DISTRO_FEATURES = "x11"
CONFLICT_DISTRO_FEATURES = "wayland"

IMAGE_FEATURES += "splash x11-base"

IMAGE_INSTALL += " \
	${QT5APPS} \
	${QT5BASE} \
"
export IMAGE_BASENAME = "yoe-qt5-x11-image"
