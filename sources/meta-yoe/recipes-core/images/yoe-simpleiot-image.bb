# Yoe sample IoT image

require yoe-simple-image.bb
DESCRIPTION = "SimpleIOT Image"

SIMPLEIOT ?= "simpleiot"
# RISCV32 does not have golang port yet so there is no use
# of building this image for rv32
SIMPLEIOT:riscv32 = ""

IMAGE_INSTALL += "\
    ${SIMPLEIOT} \
"

export IMAGE_BASENAME = "yoe-simpleiot-image"
