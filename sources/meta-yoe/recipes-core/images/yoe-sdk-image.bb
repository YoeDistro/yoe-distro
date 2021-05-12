# this image includes On-Device toolchain and debug tools

require yoe-debug-image.bb
require graphics.inc

IMAGE_FEATURES += "tools-sdk dev-pkgs"

IMAGE_INSTALL += "\
    packagegroup-go-sdk-target \
    packagegroup-core-buildessential \
    git \
    bc \
"

IMAGE_INSTALL_remove_riscv32 = "packagegroup-go-sdk-target"

export IMAGE_BASENAME = "yoe-sdk-image"
# some ptests need a lot of memory
# We can see random failures e.g. scp test failure
# NOTE: test_scp_file (scp.ScpTest)
# ...
# scp: /tmp/test_scp_file: No space left on device

QB_MEM = "-m ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', '2048', '1024', d)}"
