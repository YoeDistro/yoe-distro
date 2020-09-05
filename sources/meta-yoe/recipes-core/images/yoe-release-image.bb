# Yoe base image for using feeds

require yoe-simple-image.bb

IMAGE_INSTALL += "\
    wget \
"
export IMAGE_BASENAME = "yoe-release-image"
