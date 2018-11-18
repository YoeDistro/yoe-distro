# Yoe QT5/Wayland sample image

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

require yoe-simple-image.bb
require qt5.inc

REQUIRED_DISTRO_FEATURES = "wayland"

IMAGE_FEATURES += "splash"

CORE_IMAGE_BASE_INSTALL += " \
  weston weston-init \
  weston-examples \
  ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'weston-xwayland', '', d)} \
  ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'qtwayland-plugins', '', d)} \
  ${QT5APPS} \
  ${QT5BASE} \
"
export IMAGE_BASENAME = "yoe-qt5-wayland-image"
