# We use updater to handle disk/SD management, therefore remove 96boards-tools
IMAGE_INSTALL:remove = "96boards-tools"

KERNEL_IMAGE = "${KERNEL_IMAGETYPE}-initramfs-${MACHINE}.bin"

# Add ${KERNEL_IMAGETYPE} to KERNEL_ARTEFACTS if using u-boot
KERNEL_ARTEFACTS = "\
    bcm2711-rpi-400.dtb \
    bcm2711-rpi-4-b.dtb \
    bcm2711-rpi-cm4.dtb \
"
DTBOFILES = "\
    overlays/mcp2515-can1.dtbo \
    overlays/hifiberry-dac.dtbo \
    overlays/hifiberry-digi.dtbo \
    overlays/hifiberry-dacplus.dtbo \
    overlays/pitft28-capacitive.dtbo \
    overlays/gpio-ir.dtbo \
    overlays/iqaudio-dacplus.dtbo \
    overlays/justboom-digi.dtbo \
    overlays/justboom-dac.dtbo \
    overlays/vc4-kms-dsi-7inch.dtbo \
    overlays/mcp2515-can0.dtbo \
    overlays/i2c-rtc.dtbo \
    overlays/miniuart-bt.dtbo \
    overlays/at86rf233.dtbo \
    overlays/pitft22.dtbo \
    overlays/imx219.dtbo \
    overlays/vc4-fkms-v3d.dtbo \
    overlays/justboom-both.dtbo \
    overlays/disable-bt.dtbo \
    overlays/w1-gpio.dtbo \
    overlays/rpi-ft5406.dtbo \
    overlays/dwc2.dtbo \
    overlays/pitft28-resistive.dtbo \
    overlays/hifiberry-amp.dtbo \
    overlays/vc4-kms-v3d.dtbo \
    overlays/w1-gpio-pullup.dtbo \
    overlays/vc4-kms-v3d-pi4.dtbo \
    overlays/gpio-key.dtbo \
    overlays/gpio-ir-tx.dtbo \
    overlays/pps-gpio.dtbo \
    overlays/rpi-poe.dtbo \
    overlays/pitft35-resistive.dtbo \
    overlays/overlay_map.dtb \
    overlays/iqaudio-dac.dtbo \
    "

ROOTFS_ARTEFACTS = "rootfs.tar.xz"

BOOTLOADER_ARTEFACTS = "\
    kernel8.img \
    "
# uncomment when using u-boot
#BOOTLOADER_ARTEFACTS += "boot.scr"

BOOTFILES = "\
    bootcode.bin \
    cmdline.txt \
    config.txt \
    fixup.dat \
    fixup4.dat \
    fixup4cd.dat \
    fixup4db.dat \
    fixup4x.dat \
    fixup_cd.dat \
    fixup_db.dat \
    fixup_x.dat \
    start.elf \
    start4.elf \
    start4cd.elf \
    start4db.elf \
    start4x.elf \
    start_cd.elf \
    start_db.elf \
    start_x.elf \
    "
UPDATE_IMAGES = "version.txt ${BOOTFILES} ${BOOTLOADER_ARTEFACTS} ${KERNEL_ARTEFACTS} ${DTBOFILES} ${ROOTFS_ARTEFACTS}"

do_updater() {
}
