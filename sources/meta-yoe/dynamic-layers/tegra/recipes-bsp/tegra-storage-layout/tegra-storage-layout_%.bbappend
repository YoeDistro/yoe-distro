FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append = " file://flash_nitro_emmc_rootfs_ab_data.xml"
PARTITION_FILE = "${UNPACKDIR}/flash_nitro_emmc_rootfs_ab_data.xml"

S = "${UNPACKDIR}"
