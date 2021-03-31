# Yoe sample IoT image

require yoe-simple-image.bb
DESCRIPTION = "SimpleIOT Image"
IMAGE_INSTALL += "\
    simpleiot \
"
export IMAGE_BASENAME = "yoe-simpleiot-image"
