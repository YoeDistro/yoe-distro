SUMMARY = "Tegra swupdate update image"
DESCRIPTION = "A swupdate image for demonstrating tegra updates"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

SRC_URI = "\
    file://sw-description \
    file://bootloader-update.lua \
"

inherit swupdate image_types_tegra

DEPLOY_KERNEL_IMAGE ?= "${@os.path.basename(tegra_kernel_image(d))}"

ROOTFS_DEVICE_PATH ?= "/dev/disk/by-partlabel"

# By default, use yoe-simple-image as the base image.
# Redefine in local.conf if you'd like to use a different base image.
SWUPDATE_CORE_IMAGE_NAME ?= "yoe-simple-image"

ROOTFS_FILENAME ?= "${SWUPDATE_CORE_IMAGE_NAME}-${MACHINE}.rootfs.tar.gz"

# Handle differences in redundant partition naming on t194 platforms
KERNEL_A_PARTNAME = "A_kernel"
KERNEL_A_DTB_PARTNAME = "A_kernel-dtb"
KERNEL_B_PARTNAME = "B_kernel"
KERNEL_B_DTB_PARTNAME = "B_kernel-dtb"

# images to build before building swupdate image
IMAGE_DEPENDS = "${SWUPDATE_CORE_IMAGE_NAME} tegra-uefi-capsules"

# images and files that will be included in the .swu image
DTBFILE_PATH = "${@'${EXTERNAL_KERNEL_DEVICETREE}/${DTBFILE}' if len(d.getVar('EXTERNAL_KERNEL_DEVICETREE')) else '${DTBFILE}'}"
SWUPDATE_IMAGES = "${ROOTFS_FILENAME} tegra-bl.cap ${DEPLOY_KERNEL_IMAGE} ${DTBFILE_PATH}"

do_swuimage[depends] += "${DTB_EXTRA_DEPS}"

# Add a link using the core image name.swu to the resulting swu image
do_swuimage:append() {
    os.symlink(d.getVar("IMAGE_NAME") + ".swu", d.getVar("SWUPDATE_CORE_IMAGE_NAME") + "-" + d.getVar("MACHINE") + ".swu")
}
