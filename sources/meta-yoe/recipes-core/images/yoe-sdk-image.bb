# this image includes On-Device toolchain and debug tools

require yoe-debug-image.bb
require graphics.inc

IMAGE_FEATURES += "tools-sdk dev-pkgs"

IMAGE_INSTALL += "packagegroup-go-sdk-target packagegroup-core-buildessential"
IMAGE_INSTALL_remove_riscv32 = "packagegroup-go-sdk-target"

export IMAGE_BASENAME = "yoe-sdk-image"
# ptest needs a lot of memory
QB_MEM = "-m 1024"
