# Yoe QT5/Wayland/X11/eglfs sample image
require yoe-simple-image.bb

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

require qt5.inc
require graphics.inc

export IMAGE_BASENAME = "yoe-qt5-image"

# ptest needs a lot of memory
QB_MEM = "-m 1024"

python() {
    if 'qt5-layer' not in d.getVar('BBFILE_COLLECTIONS').split():
        raise bb.parse.SkipRecipe('Requires meta-qt5 in bblayers.conf')
}
