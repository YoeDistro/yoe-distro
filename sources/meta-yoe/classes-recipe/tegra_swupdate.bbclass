inherit l4t_version

# Set to "true" to use logic which only installs the bootloader
# when a change in L4T_VERSION is found between current and target rootfs
TEGRA_SWUPDATE_BOOTLOADER_INSTALL_ONLY_IF_DIFFERENT ?= "false"


# The version written into the sw-versions file for the
# bootloader update capsule, used to control bootloader
# updates when TEGRA_SWUPDATE_BOOTLOADER_INSTALL_ONLY_IF_DIFFERENT is "true"
# Can be set to anything, but ideally would match the value
# used for get_hex_bsp_version in tegra-uefi-capsule-signing.bbclass
# to support comparisons with runtime checks of version in
# /sys/firmware/efi/esrt/entries/entry0/fw_version
TEGRA_SWUPDATE_BOOTLOADER_VERSION ?= "${L4T_VERSION}"


TEGRA_SWUPDATE_CAPSULE_INSTALL_PATH ?= "/boot/efi/EFI/UpdateCapsule/TEGRA_BL.Cap"
