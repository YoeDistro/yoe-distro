# this image includes On-Device toolchain and debug tools

require yoe-debug-image.bb
require kiosk.inc

IMAGE_FEATURES += "tools-sdk dev-pkgs"

IMAGE_INSTALL += "packagegroup-go-sdk-target packagegroup-core-buildessential"

export IMAGE_BASENAME = "yoe-sdk-image"
