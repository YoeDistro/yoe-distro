# this image includes On-Device toolchain and debug tools

require yoe-debug-image.bb
require graphics.inc

IMAGE_FEATURES += "tools-sdk dev-pkgs"

IMAGE_INSTALL += "\
    packagegroup-go-sdk-target \
    packagegroup-core-buildessential \
    u-boot-tools-mkimage \
    u-boot-tools-mkenvimage \
    bc \
    flex \
    bison \
    git \
    jansson \
    texinfo \
    perl-module-encode perl-module-encode-encoding perl-module-locale perl-module-integer \
    perl-module-if perl-module-unicode-normalize perl-module-base perl-module-feature \
    perl-module-perlio \
    perl-module-utf8 \
"

IMAGE_INSTALL:remove:riscv32 = "packagegroup-go-sdk-target"
IMAGE_INSTALL:remove:powerpc = "packagegroup-go-sdk-target"

export IMAGE_BASENAME = "yoe-sdk-image"
# some ptests need a lot of memory
# We can see random failures e.g. scp test failure
# NOTE: test_scp_file (scp.ScpTest)
# ...
# scp: /tmp/test_scp_file: No space left on device

QB_MEM = "-m ${@bb.utils.contains('DISTRO_FEATURES', 'ptest', '2048', '1024', d)}"
