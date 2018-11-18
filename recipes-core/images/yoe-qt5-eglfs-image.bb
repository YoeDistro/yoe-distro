# Yoe QT5 sample image

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

require yoe-simple-image.bb
require qt5.inc

CONFLICT_DISTRO_FEATURES = "wayland x11"

REQUIRED_DISTRO_FEATURES = "opengl"

IMAGE_INSTALL += " \
	${QT5APPS} \
	${QT5BASE} \
"
export IMAGE_BASENAME = "yoe-qt5-eglfs-image"
