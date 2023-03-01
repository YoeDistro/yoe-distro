export PROJECT=var-dart-imx6ul
export MACHINE=imx6ul-var-dart

. ./envsetup.sh

function oe_partition_sd_mx6() {
  # this requires sfdisk >= 2.26

  if [ ! $1 ]; then
    echo "Usage: pp_partition_sd /dev/sdX"
    echo "Warning, make sure you specify your SD card and not a workstation disk"
    echo
    return 1
  fi

  DRIVE=$1

  sudo umount ${DRIVE}1 2>/dev/null
  sudo umount ${DRIVE}2 2>/dev/null
  sudo umount ${DRIVE}3 2>/dev/null

  sudo dd if=/dev/zero of=$DRIVE bs=1024 count=1024

  # sfdisk dump from working SD card
  # /dev/mmcblk0p1 : start=          63, size=      144522, type=c, bootable
  # /dev/mmcblk0p2 : start=      144585, size=     1429785, type=83
  # /dev/mmcblk0p3 : start=     1581056, size=    29736960, type=83

  {
    echo 8192,200M,0xc,*
    echo 208M,500M,
  } | sudo sfdisk ${DRIVE}

  sudo umount ${DRIVE}1 2>/dev/null
  sudo umount ${DRIVE}2 2>/dev/null
  sudo umount ${DRIVE}3 2>/dev/null

  sudo mkfs.vfat -F 32 -n "mx6-boot" ${DRIVE}1
  sudo mkfs.ext3 -L "mx6-rootfs" ${DRIVE}2
}

function oe_install_sd_spl_uboot() {
  if [ ! $1 ]; then
    echo "must pass in disk"
    echo "Warning, make sure you specify your SD card and not a workstation disk"
    echo
    return 1
  fi

  sudo dd if=${OE_DEPLOY_DIR}/SPL-sd of=${1} bs=1K seek=1
  sync
  sudo dd if=$(ls ${OE_DEPLOY_DIR}/u-boot-nand-2015.10*) of=${1} bs=1K seek=69
  sync
}

function oe_install_sd_boot() {

  if [ ! $1 ]; then
    echo "Usage: pw_prog_sd_boot /dev/sdX"
    echo "Warning, make sure you specify your SD card and not a workstation disk"
    echo
    return 1
  fi

  sudo dd if=${OE_DEPLOY_DIR}/SPL-sd of=${1} bs=1K seek=1
  sync
  sudo dd if=$(ls ${OE_DEPLOY_DIR}/u-boot-sd-1.0*) of=${1} bs=1K seek=69
  sync

  DTB_FILES=$(ls ${OE_DEPLOY_DIR}/zImage-imx6ul*.dtb)

  for DTB in $DTB_FILES; do
    DTB_=$(echo $(basename $DTB) | sed 's/zImage-//')
    cp $DTB /run/media/$USER/mx6-boot/${DTB_}
  done

  sudo cp ${OE_DEPLOY_DIR}/zImage-initramfs-${MACHINE}.bin /run/media/$USER/mx6-boot/zImage
}

function pw_install_sd_rootfs() {
  sudo rm -rf /run/media/$USER/mx6-rootfs/*
  sudo tar -C /run/media/$USER/mx6-rootfs/ -xf ${OE_DEPLOY_DIR}/pointwatch-image-imx6ul-var-dart.tar.bz2

}

function oe_install_sd_update() {
  pw_install_sd_boot $1
  sudo cp ${OE_BASE}/images/${UPDATE_IMAGE} /run/media/$USER/mx6-boot/
}

# below is in updater -- included here just for testing
function oe_find_update_file() {
  DIR=$1
  cd $DIR
  extensions="pwu img"
  update=""
  for ext in $extensions; do
    update=$(echo $(ls update_dart*.${ext} -v -r 2>/dev/null) | sed "s/update.${ext}//" | sed "s/${ext}.*/${ext}/" | sed "s/^\s*//")
    if echo $update | grep update >/dev/null; then
      echo $update
      break
    fi
  done

  if [ "${update}" = "" ]; then
    if [ -e update.img ]; then
      echo update.img
    fi
  fi
  cd - >/dev/null
}
