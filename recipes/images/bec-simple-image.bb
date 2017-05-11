# BEC sample image

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=4d92cd373abda3937c2bc47fbc49d690"

IMAGE_PREPROCESS_COMMAND = "rootfs_update_timestamp"

IMAGE_FEATURES += "ssh-server-dropbear"
IMAGE_FEATURES += "package-management"

IMAGE_INSTALL += " \
	packagegroup-core-boot \
	packagegroup-basic \
	network-hotplug \
"
export IMAGE_BASENAME = "bec-simple-image"

inherit core-image
