# Yoe sample IoT image

require yoe-simple-image.bb
oDESCRIPTION = "SimpleIOT Image"

SIMPLEIOT ?= "simpleiot"
# RISCV32 does not have golang port yet so there is no use
# of building this image for rv32
SIMPLEIOT:riscv32 = ""

IMAGE_INSTALL += "\
    ${SIMPLEIOT} \
    networkmanager \
    wireguard-tools \
"

export IMAGE_BASENAME = "yoe-simpleiot-image"
