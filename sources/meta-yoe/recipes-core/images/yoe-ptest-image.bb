# this image includes ptest packages om top of sdk image

require yoe-sdk-image.bb

REQUIRED_DISTRO_FEATURES += "ptest"

IMAGE_FEATURES += "ptest-pkgs"

IMAGE_INSTALL += "\
    ptest-runner \
"

export IMAGE_BASENAME = "yoe-ptest-image"

# This image is sufficiently large (~1.8GB) that we need to be careful that it fits in a live
# image (which has a 4GB limit), so nullify the overhead factor (1.3x out of the
# box) and explicitly add just 1100MB.
# strace-ptest in particular needs more than 500MB
IMAGE_OVERHEAD_FACTOR = "1.0"
IMAGE_ROOTFS_EXTRA_SPACE = "1124288"

# ptests need more memory than standard to avoid the OOM killer
# also lttng-tools needs /tmp that has at least 2G
QB_MEM = "-m 4096"
# Max memory supported by qemu on rv32 is 2G
QB_MEM:qemuriscv32 = "-m 2048"

# Sadly at the moment the full set of ptests is not robust enough and sporadically fails in random places
PTEST_EXPECT_FAILURE = "1"
