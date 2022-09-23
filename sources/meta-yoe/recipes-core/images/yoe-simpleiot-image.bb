# Yoe sample IoT image

require yoe-simple-image.bb
DESCRIPTION = "SimpleIOT Image"
IMAGE_INSTALL += "\
    simpleiot \
"
export IMAGE_BASENAME = "yoe-simpleiot-image"

# RISCV32 does not have golang port yet so there is no use
# of building this image for rv32
COMPATIBLE_HOST = "^(?!riscv32).*"
