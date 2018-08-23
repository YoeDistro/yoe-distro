export MACHINE=overo

. envsetup.sh

function oe_partition_sd() {
  # create 2 partitions for TI OMAP type CPUs
  # taken from a standalone script
  # (c) 2009 Graeme Gregory
  # This script is GPLv3 licensed!

  if [ ! $1 ]; then
    echo "Usage: oe_partition_sd /dev/sdX"
    echo "Warning, make sure you specify your SD card and not a workstation disk"
    echo
    return 1
  fi

  DRIVE=$1

  sudo umount ${DRIVE}1 2>/dev/null
  sudo umount ${DRIVE}2 2>/dev/null
  sudo umount ${DRIVE}3 2>/dev/null

  sudo dd if=/dev/zero of=$DRIVE bs=1024 count=1024

  echo 'sfdisk >= 2.26 detected'
  {
    echo 1M,300M,0xE,*
    echo ,,,
  } | sudo sfdisk ${DRIVE}

  sudo umount ${DRIVE}1 2>/dev/null
  # If you get the message WARNING: Not enough clusters for a 32 bit FAT!, reduce cluster -s2, or -s1
  sudo mkfs.vfat -F32 -s2 -n "boot" ${DRIVE}1

  sudo umount ${DRIVE}2 2>/dev/null
  sudo mke2fs -j -L "rootfs" ${DRIVE}2

  sudo sync

  echo "partition completed, please eject and re-insert card to detect new partitions"
}

function oe_install_sd_boot() {
  if [ -e /$MEDIA/BOOT ]; then
    OMAPBOOT="BOOT"
  else
    OMAPBOOT="boot"
  fi

  cp ${OE_DEPLOY_DIR}/MLO /$MEDIA/$OMAPBOOT/MLO
  cp ${OE_DEPLOY_DIR}/u-boot.img /$MEDIA/$OMAPBOOT/
  #cp ${OE_DEPLOY_DIR}/zImage-$MACHINE.* /$MEDIA/$OMAPBOOT/zImage
  #cp ${OE_DEPLOY_DIR}/*.dtb /$MEDIA/$OMAPBOOT/
}

function oe_install_sd_rootfs() {
  IMAGE_NAME=$1

  if [ -z $IMAGE_NAME ]; then
    echo "Usage: oe_install_sd_rootfs <image name>"
    echo "Example: oe_install_sd_rootfs systemd-image"
    return
  fi

  rf_names="rootfs root ROOT ROOTFS"

  for r in $rf_names; do
    if [ -e $MEDIA/$r ]; then
      ROOTFS=$MEDIA/$r
      break
    fi
  done

  echo "ROOTFS: $ROOTFS"

  echo "Installing rootfs files for $IMAGE_NAME ..."
  if [ ! -e $ROOTFS ]; then
    echo "rootfs not found, please insert or partition SD card"
    return 1
  fi

  sudo rm -rf $ROOTFS/*
  cd $ROOTFS/
  sudo tar -xzvf ${OE_DEPLOY_DIR}/$IMAGE_NAME-$MACHINE.tar.gz
  cd -
}
