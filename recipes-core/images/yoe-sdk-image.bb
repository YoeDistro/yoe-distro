# this image includes On-Device toolchain and debug tools

require yoe-debug-image.bb
require kiosk.inc

IMAGE_FEATURES += "tools-sdk dev-pkgs"

export IMAGE_BASENAME = "yoe-sdk-image"
