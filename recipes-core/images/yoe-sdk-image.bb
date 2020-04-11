# this image includes On-Device toolchain and debug tools

require yoe-debug-image.bb
require yoe-kiosk-image.inc

IMAGE_FEATURES += "tools-sdk dev-pkgs"

export IMAGE_BASENAME = "yoe-sdk-image"
