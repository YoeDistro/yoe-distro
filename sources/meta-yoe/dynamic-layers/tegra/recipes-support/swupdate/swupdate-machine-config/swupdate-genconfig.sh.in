#!/bin/sh
datadir=@DATADIR@
get_current_slot() {
    curslot=$(nvbootctrl get-current-slot)
    if [ $curslot -eq 1 ]; then
	echo "b"
    else
	echo "a"
    fi
}

. /etc/os-release

if [ -e /run/mfgdata/serial-number ]; then
    SERIALNUMBER=$(cat /run/mfgdata/serial-number)
elif [ -e /sys/module/fuse_burn/parameters/tegra_chip_uid ]; then
    SERIALNUMBER=$(cat /sys/module/fuse_burn/parameters/tegra_chip_uid)
else
    SERIALNUMBER="unknown"
fi

BOOTSLOT=$(get_current_slot)
ALTROOTSLOT="APP"
if [ "$BOOTSLOT" = "a" ]; then
    ALTROOTSLOT="${ALTROOTSLOT}_b"
fi


rm -f /run/swupdate/swupdate.cfg

extrased=
if [ ! -e /usr/share/swupdate/swupdate.pem ]; then
    extrased="-e /public-key-file/d"
fi
sed -e"s,@SWVERSION@,$VERSION_ID," \
    -e"s,@SERIALNUMBER@,$SERIALNUMBER," \
    -e"s,@BOOTSLOT@,$BOOTSLOT," \
    $extrased \
    /${datadir}/swupdate/swupdate.cfg.in > /run/swupdate/swupdate.cfg

rm -f /run/swupdate/sw-versions
alt_rootfs_dev="/dev/disk/by-partlabel/$ALTROOTSLOT"
tmp_mount=`mktemp -d`
mount -o ro $alt_rootfs_dev $tmp_mount
if [ -e $tmp_mount/usr/share/swupdate/sw-versions-thisslot ]; then
    echo "Setup sw-versions based on $ALTROOTSLOT"
    cp $tmp_mount/${datadir}/swupdate/sw-versions-thisslot /run/swupdate/sw-versions
else
    echo "Alternate slot $ALTROOTSLOT does not contain sw-versions, using empty file"
    touch /run/swupdate/sw-versions
fi
umount $tmp_mount
rm -rf $tmp_mount
