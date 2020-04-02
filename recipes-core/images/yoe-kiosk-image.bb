#
# Yoe Kiosk image running wpewebkit based browser
#
require yoe-simple-image.bb

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

REQUIRED_DISTRO_FEATURES = "opengl"

IMAGE_FEATURES += "splash"

CORE_IMAGE_BASE_INSTALL += " \
 ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston weston-init weston-examples', '', d)} \
  wpewebkit \
  cog \
"
#
export IMAGE_BASENAME = "yoe-kiosk-image"
