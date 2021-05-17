DEPENDS += "coreutils-native"

UPDATE_IMAGES_ ??= ""

UPDATE_IMAGES_ ?= "${UPDATE_IMAGES} update.sha256"
KERNEL_IMAGE ?= "zImage-initramfs-${MACHINE}.bin"

IMG_VERSION ?= "0.0.0"

UPDATE_IMAGE_NAME ?= "${MACHINE}"

do_updater () {
    :
}

addtask updater after do_image_complete before do_build
do_updater[depends] += "${@bb.utils.contains('IMAGE_CLASSES', 'qemuboot', '', 'yoe-installer-image:do_image_complete' ,d)}"
do_updater[depends] += "${PN}:do_image_complete"
do_updater[depends] += "virtual/kernel:do_deploy"
# We want to build updater everytime we build image
do_updater[nostamp] = "1"

# Define this file for each machine in machine/ subdir
include machines/${MACHINE}.inc
