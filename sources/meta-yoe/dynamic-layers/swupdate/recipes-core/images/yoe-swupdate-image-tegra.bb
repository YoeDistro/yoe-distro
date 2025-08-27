SUMMARY = "Tegra swupdate update image"
DESCRIPTION = "A swupdate image for demonstrating tegra updates"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "\
    file://sw-description \
"

inherit swupdate image_types_tegra tegra_swupdate

DEPLOY_KERNEL_IMAGE ?= "${@os.path.basename(tegra_kernel_image(d))}"

ROOTFS_DEVICE_PATH ?= "/dev/disk/by-partlabel"

# By default, use yoe-simple-image as the base image.
# Redefine in local.conf if you'd like to use a different base image.
SWUPDATE_CORE_IMAGE_NAME ?= "yoe-simple-image"

ROOTFS_FILENAME ?= "${SWUPDATE_CORE_IMAGE_NAME}-${MACHINE}.rootfs.tar.gz"

KERNEL_A_PARTNAME = "A_kernel"
KERNEL_A_DTB_PARTNAME = "A_kernel-dtb"
KERNEL_B_PARTNAME = "B_kernel"
KERNEL_B_DTB_PARTNAME = "B_kernel-dtb"

# images to build before building swupdate image. For any non image depends, add to the do_swuimage[depends] instead.
IMAGE_DEPENDS = "${SWUPDATE_CORE_IMAGE_NAME} tegra-espimage"

ESP_ARCHIVE ?= "${TEGRA_ESP_IMAGE}-${MACHINE}.tar.gz"

# Prepend "devicetree" to the ${DTBFILE} in the images list, since this is the target for do_deploy
# On the nvidia-kernel-oot-dtb recipe.
DTBFILE_PATH = "devicetree/${DTBFILE}"

# images and files that will be included in the .swu image
SWUPDATE_IMAGES = "${ROOTFS_FILENAME} tegra-bl.cap ${DEPLOY_KERNEL_IMAGE} ${DTBFILE_PATH} tegra-swupdate-script.lua ${ESP_ARCHIVE}"

# All non-image related depends go here
do_swuimage[depends] += "${@'virtual/dtb:do_deploy' if d.getVar('PREFERRED_PROVIDER_virtual/dtb') else ''}"
do_swuimage[depends] += "virtual/kernel:do_deploy"
do_swuimage[depends] += "tegra-uefi-capsules:do_deploy"
do_swuimage[depends] += "tegra-swupdate-script:do_deploy"

# Add a link using the core image name.swu to the resulting swu image
do_swuimage:append() {
    os.symlink(d.getVar("IMAGE_NAME") + ".swu", d.getVar("SWUPDATE_CORE_IMAGE_NAME") + "-" + d.getVar("MACHINE") + ".swu")
}
