# Yoe QT6/Wayland/X11/eglfs sample image
require yoe-simple-image.bb

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

require graphics.inc

CORE_IMAGE_EXTRA_INSTALL += " \
  packagegroup-qt6-modules \
  ${QT6EXAMPLES} \
"

QT6EXAMPLES += " \
  qtvirtualkeyboard-examples \
  qtbase-examples \
  qtmultimedia-examples \
  qtwebengine-examples \
"
export IMAGE_BASENAME = "yoe-qt6-image"

# ptest needs a lot of memory
QB_MEM = "-m 1024"

python() {
    if 'qt6-layer' not in d.getVar('BBFILE_COLLECTIONS').split():
        raise bb.parse.SkipRecipe('Requires meta-qt6 in bblayers.conf')
}


