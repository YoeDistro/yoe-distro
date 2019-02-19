export MACHINE=sama5d27-som1-ek-sd

. ./envsetup.sh

yoe_sam_build_bootstrap_tools() {
  bitbake sam-ba
  bitbake at91bootstrap-sam-ba
}

SAMBA=${OE_DEPLOY_DIR}/sam-ba/sam-ba
BOOT=${OE_DEPLOY_DIR}/at91bootstrap-sama5d27_som1_ek.bin-sam-ba
UBOOT=${OE_DEPLOY_DIR}/u-boot.bin

yoe_sam_load_uboot_via_samba() {
  echo "lowlevel"
  ${SAMBA} -p serial:ttyACM0 -b sama5d27-som1-ek -t 5 -a lowlevel || exit 1
  echo "extram"
  ${SAMBA} -p serial:ttyACM0 -b sama5d27-som1-ek -t 5 -a extram || exit 1
  echo "download bootstrap"
  ${SAMBA} -p serial:ttyACM0 -b sama5d27-som1-ek -m write:${BOOT}:0x200000 || exit 1
  echo "download u-boot"
  ${SAMBA} -p serial:ttyACM0 -b sama5d27-som1-ek -m write:${UBOOT}:0x23F00000 || exit 1
  echo "jump to bootstrap"
  ${SAMBA} -p serial:ttyACM0 -b sama5d27-som1-ek -m execute:0x200000 || exit 1
  screen /dev/ttyACM0 115200
}

yoe_sam_install_bootstrap_files() {
  # this assumes you have bootstrapped the system over serial
  # using the above script.

  if [ -z "$1" ]; then
    echo
    echo "Usage: is_install_bootstrap_files <install dir>"
    echo
    return 1
  fi

  IMG_VERSION=$(yoe_get_image_version)
  echo IMG_VERSION=$IMG_VERSION

  cp ${OE_DEPLOY_DIR}/zImage-initramfs-${MACHINE}.bin $1/zImage
  cp ${OE_DEPLOY_DIR}/at91-sama5d27_som1_ek.dtb $1
  cp ${OE_BASE}/images/${MACHINE}_${IMG_VERSION}.upd $1
}
