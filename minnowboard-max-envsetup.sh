export MACHINE=minnowboard-max

. envsetup.sh

# Minnowboard max functions
function oe_partition_sd_mbm() {
  if [ ! $1 ]; then
    echo "Usage: oe_partition_sd /dev/sdX"
    echo "Warning, make sure you specify your SD card and not a workstation disk"
    echo
    return 1
  fi

  DEVICE=$1

  sudo echo "starting ..." || return 1
  sudo umount ${DEVICE}1 2>/dev/null
  sudo umount ${DEVICE}2 2>/dev/null
  sudo umount ${DEVICE}3 2>/dev/null

  DEVICE_SIZE=$(sudo parted -s $DEVICE unit mb print | grep ^Disk | cut -d" " -f 3 | sed -e "s/MB//")
  if [ "$DEVICE_SIZE" = "" ]; then
    parted -s $DEVICE mklabel msdos || return 1
    DEVICE_SIZE=$(sudo parted -s $DEVICE unit mb print | grep ^Disk | cut -d" " -f 3 | sed -e "s/MB//")
  fi

  BOOT_SIZE=100
  ROOTFS_SIZE=700

  ROOTFS_SIZE=$((DEVICE_SIZE - BOOT_SIZE))
  ROOTFS_START=$((BOOT_SIZE))
  ROOTFS_END=$((ROOTFS_START + ROOTFS_SIZE))

  echo "DEVICE_SIZE: $DEVICE_SIZE"
  echo "ROOTFS_SIZE: $ROOTFS_SIZE"
  echo "ROOTFS_START: $ROOTFS_START"
  echo "ROOTFS_END: $ROOTFS_END"

  return

  sudo dd if=/dev/zero of=$DEVICE bs=512 count=2 || return 1
  sudo parted -s $DEVICE mklabel msdos || return 1
  sudo parted -s $DEVICE mkpart primary 0% $BOOT_SIZE || return 1
  sudo parted -s $DEVICE set 1 boot on || return 1
  sudo parted -s $DEVICE mkpart primary $ROOTFS_START $ROOTFS_END || return 1
  sudo mkfs.vfat -I ${DEVICE}1 -n "EFI" || return 1
  sudo mkfs.ext3 -F ${DEVICE}2 -L "ROOT" || return 1

  echo "all done :-)"
}

function oe_install_sd_boot_mbm() {
  cp ${OE_DEPLOY_DIR}/bzImage /$MEDIA/EFI/vmlinuz.efi
  echo "vmlinuz.efi root=/dev/mmcblk0p2 ro rootwait quiet console=ttyS0,115200 console=tty0" >/$MEDIA/EFI/startup.nsh
}
