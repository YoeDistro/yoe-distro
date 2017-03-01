#!/bin/bash

# Original script done by Don Darling
# Later changes by Koen Kooi and Brijesh Singh

# Revision history:
# 20090902: download from twiki
# 20090903: Weakly assign MACHINE and DISTRO
# 20090904:  * Don't recreate local.conf is it already exists
#            * Pass 'unknown' machines to OE directly
# 20090918: Fix /bin/env location
#           Don't pass MACHINE via env if it's not set
#           Changed 'build' to 'bitbake' to prepare people for non-scripted usage
#           Print bitbake command it executes
# 20091012: Add argument to accept commit id.
# 20091202: Fix proxy setup

# Changes by Cliff Brake
# 20111101: modify script to work with BEC build template
#

if [ -f local.sh ]; then
  echo "reading local settings"
  source local.sh
fi

BUILDHOST_DISTRO=`egrep -h '^ID=' /etc/*-release | sed 's#^ID=##'`

case $BUILDHOST_DISTRO in
    arch)
	NODEJS=node
	;;
    ubuntu)
	NODEJS=nodejs
	;;
	*)
	NODEJS=nodejs
	;;
esac

###############################################################################
# Machine/Distro setup -- this is the main configuration for the build
# these variables can be set externally in the shell, or here
###############################################################################

if [ -z "${MACHINE}" ]; then
  export MACHINE=beaglebone
  echo "Setting MACHINE=$MACHINE"
fi

case $MACHINE in
  beagleboard|beaglebone|overo|wandboard-dual|imx6ul-var-dart)
    export MACHINE_ARCH=armv7at2hf-vfp-neon
    export MACHINE_SUBARCH=armv7ahf-vfp-neon
    ;;
  intel-corei7-64)
    export MACHINE_ARCH=x86_64
    export MACHINE_SUBARCH=intel_corei7_64
    ;;
  *)
    echo "Note: Don't know how to set MACHINE_ARCH and MACHINE_SUBARCH"
esac

if [ -z "${MEDIA}" ]; then
  # set the location of the automounted location for removable storage
  # newer gnome systems
  # export MEDIA=/run/media/$USER

  # older systems
  export MEDIA=/media/

fi

###############################################################################
# User specific vars like proxy servers
###############################################################################

#PROXYHOST=wwwgate.ti.com
#PROXYPORT=80
PROXYHOST=""

###############################################################################
# OE_BASE    - The root directory for all OE sources and development.
###############################################################################
OE_BASE=$(/bin/readlink -f `dirname '${0}'`)

cd $OE_BASE

# incremement this to force recreation of config files.  This should be done
# whenever the DISTRO, or anything major changes
BASE_VERSION=10
OE_ENV_FILE=localconfig.sh

# Workaround for differences between yocto bitbake and vanilla bitbake
export BBFETCH2=True

export DISTRO_DIRNAME=`echo $DISTRO | sed 's#[.-]#_#g'`
export OE_DEPLOY_DIR=${OE_BASE}/build/tmp/deploy/images/${MACHINE}

#--------------------------------------------------------------------------
# Specify the root directory for your OpenEmbedded development
#--------------------------------------------------------------------------
OE_BUILD_DIR=${OE_BASE}
OE_BUILD_TMPDIR="${OE_BUILD_DIR}/build/tmp"
OE_SOURCE_DIR=${OE_BASE}/sources

export BUILDDIR=${OE_BUILD_DIR}
mkdir -p ${OE_BUILD_DIR}
mkdir -p ${OE_SOURCE_DIR}
export OE_BASE

#--------------------------------------------------------------------------
# Include up-to-date bitbake in our PATH.
#--------------------------------------------------------------------------
export PATH=${OE_SOURCE_DIR}/openembedded-core/scripts:${OE_SOURCE_DIR}/bitbake/bin:${PATH}
export PATH=${OE_BASE}/tools:${PATH}
# remove duplicate entries from path
# export PATH=`echo $PATH_ | awk -F: '{for (i=1;i<=NF;i++) { if ( !x[$i]++ ) printf("%s:",$i); }}'`
export PATH=`awk -F: '{for(i=1;i<=NF;i++){if(!($i in a)){a[$i];printf s$i;s=":"}}}'<<<$PATH`

#--------------------------------------------------------------------------
# Make sure Bitbake doesn't filter out the following variables from our
# environment.
#--------------------------------------------------------------------------
export BB_ENV_EXTRAWHITE="MACHINE DISTRO TCLIBC TCMODE GIT_PROXY_COMMAND http_proxy ftp_proxy https_proxy all_proxy ALL_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY SDKMACHINE BB_NUMBER_THREADS OE_BASE SVS_VERSION"

#--------------------------------------------------------------------------
# Specify proxy information
#--------------------------------------------------------------------------
if [ "x$PROXYHOST" != "x"  ] ; then
    export http_proxy=http://${PROXYHOST}:${PROXYPORT}/
    export ftp_proxy=http://${PROXYHOST}:${PROXYPORT}/

    export SVN_CONFIG_DIR=${OE_BUILD_DIR}/subversion_config
    export GIT_CONFIG_DIR=${OE_BUILD_DIR}/git_config

    export GIT_PROXY_COMMAND="${GIT_CONFIG_DIR}/git-proxy.sh"

    config_svn_proxy
    config_git_proxy
fi

#--------------------------------------------------------------------------
# Set up the bitbake path to find the OpenEmbedded recipes.
#--------------------------------------------------------------------------
export BBPATH=${OE_BUILD_DIR}:${OE_SOURCE_DIR}/openembedded-core/meta${BBPATH_EXTRA}

#--------------------------------------------------------------------------
# Reconfigure dash
#--------------------------------------------------------------------------
if [ "$(readlink /bin/sh)" = "dash" ] ; then
    sudo aptitude install expect -y
    expect -c 'spawn sudo dpkg-reconfigure -freadline dash; send "n\n"; interact;'
fi


#--------------------------------------------------------------------------
# If an env already exists, use it, otherwise generate it
#--------------------------------------------------------------------------

if [ -e ${OE_ENV_FILE} ] ; then
    source ${OE_ENV_FILE}
fi

if [ x"${BASE_VERSION}" != x"${SCRIPTS_BASE_VERSION}" ] ; then
	echo "BASE_VERSION mismatch, recreating ${OE_ENV_FILE}"
	rm -f ${OE_ENV_FILE}

elif [ x"${DISTRO_DIRNAME}" != x"${SCRIPTS_DISTRO_DIRNAME}" ] ; then
  echo "DISTRO name has changed, recreating ${OE_ENV_FILE}"
  rm -f ${OE_ENV_FILE}
fi

if [ -e ${OE_ENV_FILE} ] ; then
    source ${OE_ENV_FILE}
else

    #--------------------------------------------------------------------------
    # Specify distribution information
    #--------------------------------------------------------------------------

    echo "export SCRIPTS_BASE_VERSION=${BASE_VERSION}" > ${OE_ENV_FILE}
    echo "export SCRIPTS_DISTRO_DIRNAME=\"${DISTRO_DIRNAME}\"" >> ${OE_ENV_FILE}


    echo "${OE_ENV_FILE} created"

    #--------------------------------------------------------------------------
    # Write out the OE bitbake configuration file.
    #--------------------------------------------------------------------------
    mkdir -p ${OE_BUILD_DIR}/conf

    SITE_CONF=${OE_BUILD_DIR}/conf/site.conf
    cat > $SITE_CONF <<_EOF

SCONF_VERSION = "1"

# Where to store sources
DL_DIR = "${OE_BASE}/downloads"

# Where to save shared state
SSTATE_DIR = "${OE_BUILD_DIR}/build/sstate-cache"

# Which files do we want to parse:
BBFILES ?= "${OE_SOURCE_DIR}/openembedded-core/meta/recipes-*/*/*.bb"

TMPDIR = "${OE_BUILD_DIR}/build/tmp"

# Go through the Firewall
#HTTP_PROXY        = "http://${PROXYHOST}:${PROXYPORT}/"

_EOF

    echo "${SITE_CONF} has been updated"

fi # if -e ${OE_ENV_FILE}

###############################################################################
# UPDATE_ALL() - Make sure everything is up to date
###############################################################################
function oe_update_all()
{
    git submodule update
}

function oe_update_all_submodules_to_master
{
  git submodule foreach "git checkout master && git pull"
}

###############################################################################
# CLEAN_OE() - Delete TMPDIR
###############################################################################
function oe_clean()
{
    echo "Cleaning ${OE_BUILD_TMPDIR}"
    rm -rf ${OE_BUILD_TMPDIR}
}


###############################################################################
# OE_CONFIG() - Configure OE for a target
# machine is first parameter
###############################################################################
function oe_setup()
{
    git submodule init
    git submodule update

}

###############################################################################
# CONFIG_SVN_PROXY() - Configure subversion proxy information
###############################################################################
function oe_config_svn_proxy()
{
    if [ ! -f ${SVN_CONFIG_DIR}/servers ]
    then
        mkdir -p ${SVN_CONFIG_DIR}
        cat >> ${SVN_CONFIG_DIR}/servers <<_EOF
[global]
http-proxy-host = ${PROXYHOST}
http-proxy-port = ${PROXYPORT}
_EOF
    fi
}


###############################################################################
# CONFIG_GIT_PROXY() - Configure GIT proxy information
###############################################################################
function oe_config_git_proxy()
{
    if [ ! -f ${GIT_CONFIG_DIR}/git-proxy.sh ]
    then
        mkdir -p ${GIT_CONFIG_DIR}
        cat > ${GIT_CONFIG_DIR}/git-proxy.sh <<_EOF
if [ -x /bin/env ] ; then
    exec /bin/env corkscrew ${PROXYHOST} ${PROXYPORT} \$*
else
    exec /usr/bin/env corkscrew ${PROXYHOST} ${PROXYPORT} \$*
fi
_EOF
        chmod +x ${GIT_CONFIG_DIR}/git-proxy.sh
        export GIT_PROXY_COMMAND=${GIT_CONFIG_DIR}/git-proxy.sh
    fi
}

function oe_partition_sd_3()
{
  # create 3 partitions for TI OMAP type CPUs
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

  SIZE=`sudo fdisk -l $DRIVE | grep Disk | awk '{print $5}'`

  echo DISK SIZE - $SIZE bytes

  CYLINDERS=`echo $SIZE/255/63/512 | bc`
  CYLINDER_SIZE=`echo $SIZE/$CYLINDERS | bc`
  CYLINDERS_ROOTFS=`echo 700*1024*1024/$CYLINDER_SIZE | bc`

  echo CYLINDERS - $CYLINDERS
  echo CYLINDERS in rootfs - $CYLINDERS_ROOTFS

  {
  echo ,9,0x0C,*
  echo ,$CYLINDERS_ROOTFS,0x83,-
  echo ,,0x83,-
  } | sudo sfdisk -D -H 255 -S 63 -C $CYLINDERS $DRIVE

  sudo umount ${DRIVE}1 2>/dev/null
  # If you get the message WARNING: Not enough clusters for a 32 bit FAT!, reduce cluster -s2, or -s1
  sudo mkfs.vfat -F32 -s2 -n "boot" ${DRIVE}1

  sudo umount ${DRIVE}2 2>/dev/null
  sudo mke2fs -j -L "rootfs" ${DRIVE}2

  sudo umount ${DRIVE}3 2>/dev/null
  sudo mke2fs -j -L "omap-data" ${DRIVE}3
}

function oe_partition_sd()
{
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

  sudo dd if=/dev/zero of=$DRIVE bs=1024 count=1024

  SIZE=`sudo fdisk -l $DRIVE | grep Disk | awk '{print $5}'`

  echo DISK SIZE - $SIZE bytes

  CYLINDERS=`echo $SIZE/255/63/512 | bc`
  CYLINDER_SIZE=`echo $SIZE/$CYLINDERS | bc`
  CYLINDERS_ROOTFS=`echo 512*1024*1024/$CYLINDER_SIZE | bc`

  echo CYLINDERS - $CYLINDERS
  echo CYLINDERS in rootfs - $CYLINDERS_ROOTFS

  {
  echo ,9,0x0C,*
  echo ,,0x83,-
  } | sudo sfdisk -D -H 255 -S 63 -C $CYLINDERS $DRIVE

  sudo umount ${DRIVE}1 2>/dev/null
  # If you get the message WARNING: Not enough clusters for a 32 bit FAT!, reduce cluster -s2, or -s1
  sudo mkfs.vfat -F32 -s2 -n "omap-boot" ${DRIVE}1

  sudo umount ${DRIVE}2 2>/dev/null
  sudo mke2fs -j -L "rootfs" ${DRIVE}2
}

function oe_partition_sd_imx6()
{
  echo "TODO"
}

function oe_install_sd_rootfs
{
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

function oe_install_sd_boot
{
  if [ -e /$MEDIA/OMAP-BOOT ]; then
    OMAPBOOT="OMAP-BOOT"
  else
    OMAPBOOT="omap-boot"
  fi

  cp ${OE_DEPLOY_DIR}/MLO /$MEDIA/$OMAPBOOT/MLO
  cp ${OE_DEPLOY_DIR}/u-boot.img /$MEDIA/$OMAPBOOT/
  cp ${OE_DEPLOY_DIR}/uImage-$MACHINE.* /$MEDIA/$OMAPBOOT/uImage
}

# Minnowboard max functions
function oe_partition_sd_mbm()
{
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
  if [ "$DEVICE_SIZE" = "" ] ; then
    parted -s $DEVICE mklabel msdos || return 1
    DEVICE_SIZE=$(sudo parted -s $DEVICE unit mb print | grep ^Disk | cut -d" " -f 3 | sed -e "s/MB//")
  fi

  BOOT_SIZE=100
  ROOTFS_SIZE=700

  ROOTFS_SIZE=$((DEVICE_SIZE-BOOT_SIZE))
  ROOTFS_START=$((BOOT_SIZE))
  ROOTFS_END=$((ROOTFS_START+ROOTFS_SIZE))

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

function oe_install_sd_boot_mbm()
{
  cp ${OE_DEPLOY_DIR}/bzImage /$MEDIA/EFI/vmlinuz.efi
  echo "vmlinuz.efi root=/dev/mmcblk0p2 ro rootwait quiet console=ttyS0,115200 console=tty0" > /$MEDIA/EFI/startup.nsh
}

function oe_feed_server()
{
  cd $OE_BASE
  bitbake package-index
  $NODEJS tools/feed-server/app.js
  cd -
}

function oe_setup_feed_server()
{
  # set MACHINE_IP in local.sh
  HOST_IP=`hostname -i | tr -d ' '`
  ssh root@$MACHINE_IP "rm /etc/opkg/*feed*"
  ssh root@$MACHINE_IP "echo 'src/gz all http://$HOST_IP:4000/all' > /etc/opkg/base-feed.conf"
  ssh root@$MACHINE_IP "echo 'src/gz $MACHINE_ARCH http://$HOST_IP:4000/$MACHINE_ARCH' >> /etc/opkg/base-feed.conf"
  ssh root@$MACHINE_IP "echo 'src/gz $MACHINE_SUBARCH http://$HOST_IP:4000/$MACHINE_SUBARCH' >> /etc/opkg/base-feed.conf"
  ssh root@$MACHINE_IP "echo 'src/gz $MACHINE http://$HOST_IP:4000/$MACHINE' >> /etc/opkg/base-feed.conf"
}

function oe_search_file()
{
  if [ -z $1 ]; then 
    echo "Usage: oe_search_file filename"
    return
  fi
  cd $OE_BASE/sources
  find -name downloads -prune -o -name $1 -print
  cd -
}

function oe_search_text()
{
  if test -z $1; then 
    echo "Usage: oe_search_text searchtext"
    return
  fi
  cd $OE_BASE/sources
  find -name downloads -prune -o -type f -print | xargs grep $1
  cd -
}

function oe_console()
{
  # requires serial->usb device be mapped to /dev/ttyUSB_<machine name>
  # see http://bec-systems.com/site/1004/perisistent-device-names-usb-serial-ports
  screen /dev/ttyUSB_${MACHINE} 115200
}

function oe_build_all()
{
  # build images for all routinely tested platforms
  MACHINES="beagleboard beaglebone overo wandboard-dual imx6ul-var-dart"
  for m in $MACHINES; do
    echo "=========================="
    echo "Building $m ....."
    export MACHINE=$m
    if ! bitbake systemd-image; then
      return
    fi
  done
}

function oe_clean_sstate()
{
  $OE_BASE/sources/openembedded-core/scripts/sstate-cache-management.sh -d --cache-dir=$OE_BASE/build/sstate-cache
}

# Docker integration
# set DOCKER_REPO to something like cbrake/oe-build
# Note, set DOCKER_REPO outside of envsetup.sh, otherwise
# it will get set in container, which is not what you want.
# local.sh is a good place to set DOCKER_REPO

function dkr()
{
  CMD=$1

  if [ ! $CMD ]; then
    echo "setting dkr action to shell"
    CMD=/bin/bash
  fi

  docker run --rm -it  \
    -v $(pwd):$(pwd) \
    -v ~/.ssh:/home/build/.ssh \
    -v ~/.gitconfig:/home/build/.gitconfig \
    -e MACHINE=$MACHINE \
    ${DOCKER_REPO} /bin/bash -c "cd $(pwd) && . envsetup.sh && $CMD $2 $3 $4 $5 $6 $7 $8"
}

function bitbake()
{
  if [ -z $DOCKER_REPO ]; then
    ${OE_BASE}/sources/bitbake/bin/bitbake $@
  else
    dkr "${OE_BASE}/sources/bitbake/bin/bitbake $@"
  fi
}

###############################################################################
# setup for cross compiling programs manually
# the following variables are needed to cross compile kernel/u-boot,
# most applications, Qt apps, etc.
###############################################################################

BUILD_ARCH=`uname -m`
CROSS_COMPILER_PATH=${OE_BUILD_TMPDIR}-glibc/sysroots/${BUILD_ARCH}-linux/usr/bin/$MACHINE_ARCH-bec-linux-gnueabi
OE_SYSROOTS_USR_BIN=${OE_BUILD_TMPDIR}-glibc/sysroots/${BUILD_ARCH}-linux/usr/bin
OE_SYSROOTS_USR_SBIN=${OE_BUILD_TMPDIR}-glibc/sysroots/${BUILD_ARCH}-linux/usr/sbin
export PATH=$CROSS_COMPILER_PATH:$OE_SYSROOTS_USR_BIN:$OE_SYSROOTS_USR_SBIN:$PATH
export ARCH=arm
export CROSS_COMPILE=arm-bec-linux-gnueabi-

export PKG_CONFIG_PATH=${OE_BUILD_TMPDIR}-glibc/sysroots/cm-x270/usr/lib/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=${OE_BUILD_TMPDIR}-glibc/sysroots/cm-x270

# FIXME, the rest needs finished
export QMAKESPEC="${TOPDIR}/tmp/sysroots/armv7a-bec-linux-gnueabi/usr/share/qt4/mkspecs/linux-gnueabi-bec-g++"

export OE_QMAKE_CC=arm-bec-linux-gnueabi-gcc
export OE_QMAKE_CXX=arm-bec-linux-gnueabi-g++
export OE_QMAKE_LINK=arm-bec-linux-gnueabi-g++
export OE_QMAKE_LIBDIR_QT="${TOPDIR}/tmp/sysroots/armv7a-bec-linux-gnueabi/usr/lib"
export OE_QMAKE_INCDIR_QT="${TOPDIR}/tmp/sysroots/armv7a-bec-linux-gnueabi/usr/include/qt4"
export OE_QMAKE_MOC="${TOPDIR}/tmp/sysroots/x86_64-linux/usr/bin/moc4"
export OE_QMAKE_UIC="${TOPDIR}/tmp/sysroots/x86_64-linux/usr/bin/uic4"
export OE_QMAKE_UIC3="${TOPDIR}/tmp/sysroots/x86_64-linux/usr/bin/uic34"
export OE_QMAKE_RCC="${TOPDIR}/tmp/sysroots/x86_64-linux/usr/bin/rcc4"
export OE_QMAKE_QDBUSCPP2XML="${TOPDIR}/tmp/sysroots/x86_64-linux/usr/bin/qdbuscpp2xml4"
export OE_QMAKE_QDBUSXML2CPP="${TOPDIR}/tmp/sysroots/x86_64-linux/usr/bin/qdbusxml2cpp4"
export OE_QMAKE_QT_CONFIG="{TOPDIR}/tmp/sysroots/x86_64-linux/usr/share/qtopia/mkspecs/qconfig.pri"




