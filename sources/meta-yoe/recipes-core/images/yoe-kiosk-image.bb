#
# Yoe Kiosk image running wpewebkit based browser
#
require yoe-simple-image.bb
require graphics.inc

export IMAGE_BASENAME = "yoe-kiosk-image"
# ptest needs a lot of memory
QB_MEM = "-m 1024"
