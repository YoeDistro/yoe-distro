#!/bin/sh

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

rm -f /run/swupdate/swupdate.cfg

extrased=
if [ ! -e /usr/share/swupdate/swupdate.pem ]; then
    extrased="-e /public-key-file/d"
fi
sed -e"s,@SWVERSION@,$VERSION_ID," \
    -e"s,@SERIALNUMBER@,$SERIALNUMBER," \
    -e"s,@BOOTSLOT@,$BOOTSLOT," \
    $extrased \
    /usr/share/swupdate/swupdate.cfg.in > /run/swupdate/swupdate.cfg
