export MACHINE=sama5d27-som1-ek-sd

. ./envsetup.sh

yoe_sam_build_bootstrap_tools() {
  bitbake sam-ba
  bitbake at91bootstrap-sam-ba
}

export YOE_SAMBA=${OE_DEPLOY_DIR}/sam-ba/sam-ba
export YOE_SAMBA_BOOT=${OE_DEPLOY_DIR}/at91bootstrap-sama5d27_som1_ek.bin
export YOE_SAMBA_BOOT_NOLOAD=${OE_DEPLOY_DIR}/at91bootstrap-sama5d27_som1_ek.bin-sam-ba
export YOE_SAMBA_UBOOT=${OE_DEPLOY_DIR}/u-boot.bin
export YOE_SAMBA_DTB=${OE_DEPLOY_DIR}/at91-sama5d27_som1_ek.dtb
export YOE_SAMBA_KERNEL=${OE_DEPLOY_DIR}/zImage-initramfs-sama5d27-som1-ek-sd.bin

yoe_samba_get_port() {
  # note you can override the below variables in local.sh
  if [ -z "$YOE_SAMBA_UART" ]; then
    YOE_SAMBA_UART=ttyACM0
  fi
  if [ -z "$YOE_SAMBA_PORT" ]; then
    YOE_SAMBA_PORT=serial
  fi

  if [ $YOE_SAMBA_PORT = "serial" ]; then
    echo $YOE_SAMBA_PORT:$YOE_SAMBA_UART
  else
    echo $YOE_SAMBA_PORT
  fi
}

# this attempts to load at91boostrap, u-boot, and kernel over SAM-BA
# if using serial port, it takes awhile
yoe_samba_load_at91bootstrap_uboot_kernel() {
  PORT=$(yoe_samba_get_port)
  echo "samba port: $PORT"
  echo "lowlevel"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -t 5 -a lowlevel || return 1
  echo "extram"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -t 5 -a extram || return 1
  echo "download bootstrap"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m write:${YOE_SAMBA_BOOT_NOLOAD}:0x200000 || return 1
  echo "download u-boot"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m write:${YOE_SAMBA_UBOOT}:0x23F00000 || return 1
  echo "download dtb"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m write:${YOE_SAMBA_DTB}:0x21000000 || return 1
  echo "download kernel"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m write:${YOE_SAMBA_KERNEL}:0x22000000 || return 1
  echo "jump to bootstrap"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m execute:0x200000 || return 1
  screen /dev/${YOE_SAMBA_UART} 115200
}

# this is the recommended way to load u-boot via samba as you get the
# cpu initialization of at91bootstrap, which seems to be required for the kernel
# to run.
yoe_samba_load_at91bootstrap_uboot() {
  PORT=$(yoe_samba_get_port)
  echo "samba port: $PORT"
  echo "lowlevel"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -t 5 -a lowlevel || return 1
  echo "extram"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -t 5 -a extram || return 1
  echo "download bootstrap"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m write:${YOE_SAMBA_BOOT_NOLOAD}:0x200000 || return 1
  echo "download u-boot"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m write:${YOE_SAMBA_UBOOT}:0x23F00000 || return 1
  echo "jump to bootstrap"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m execute:0x200000 || return 1
  screen /dev/${YOE_SAMBA_UART} 115200
}

# the following loads only at91bootstrap and skips u-boot -- may be useful
# for low level debugging/testing
yoe_samba_load_at91bootstrap() {
  PORT=$(yoe_samba_get_port)
  echo "samba port: $PORT"
  echo "lowlevel"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -t 5 -a lowlevel || return 1
  #echo "extram"
  #${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -t 5 -a extram || return 1
  echo "download bootstrap"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m write:${YOE_SAMBA_BOOT}:0x200000 || return 1
  echo "jump to bootstrap"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m execute:0x200000 || return 1
  screen /dev/${YOE_SAMBA_UART} 115200
}

# the following script downloads u-boot into SDRAM and jumps to it directly, skipping
# at91bootstrap. This typically will get you into u-boot, but the kernel silently crashes
# when starting, so there seems to be something missing from a91bootstrap that the kernel
# needs. However, this may be useful for debugging if you suspect a problem in
# at91bootstrap.
yoe_samba_load_uboot() {
  PORT=$(yoe_samba_get_port)
  echo "samba port: $PORT"
  echo "lowlevel"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -t 5 -a lowlevel || return 1
  echo "extram"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -t 5 -a extram || return 1
  echo "download u-boot"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m write:${YOE_SAMBA_UBOOT}:0x23F00000 || return 1
  echo "jump to bootstrap"
  ${YOE_SAMBA} -p $PORT -b sama5d27-som1-ek -m execute:0x23F00000 || return 1
  screen /dev/${YOE_SAMBA_UART} 115200
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
