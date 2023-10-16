#
# Yoe Kiosk image running QtWebengine based browser
#
require yoe-simpleiot-image.bb
require graphics.inc

CORE_IMAGE_EXTRA_INSTALL += " \
  liberation-fonts \
  yoe-kiosk-browser \
  qtvirtualkeyboard \
"
# chromium works on aarch64/arm32/x86 only
# qtwebview and qtwebengine needs it, yoe-kiosk-browser
# needs qtwebengine
CORE_IMAGE_EXTRA_INSTALL:remove:riscv64 = "qtwebengine-examples yoe-kiosk-browser"
CORE_IMAGE_EXTRA_INSTALL:remove:riscv32 = "qtwebengine-examples yoe-kiosk-browser"

TOOLCHAIN_HOST_TASK:append = " nativesdk-packagegroup-qt6-toolchain-host"

export IMAGE_BASENAME = "yoe-kiosk-image"
# ptest needs a lot of memory
QB_MEM = "-m 1024"

python() {
    if 'qt6-layer' not in d.getVar('BBFILE_COLLECTIONS').split():
        raise bb.parse.SkipRecipe('Requires meta-qt6 in bblayers.conf')
}
