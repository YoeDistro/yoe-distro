#!/usr/bin/env bash

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
  . ./local.sh
fi
BUILDHOST_DISTRO=$(egrep -h '^ID=' /etc/*-release | sed 's#^ID=##')

if [ "${0##*/}" = "dash" ]; then
  echo "dash shell is not supported"
  return
fi
###############################################################################
# Reconfigure dash on debian-like systems
###############################################################################
which aptitude >/dev/null 2>&1
ret=$?
if [ "$(readlink /bin/sh)" = "dash" -a "$ret" = "0" ]; then
  sudo aptitude install expect pv -y
  expect -c 'spawn sudo dpkg-reconfigure -freadline dash; send "n\n"; interact;'
elif [ "${0##*/}" = "dash" ]; then
  echo "dash as default shell is not supported"
  return
fi

###############################################################################
# Machine/Distro setup -- this is the main configuration for the build
# these variables can be set externally in the shell, or here
###############################################################################

# Try to infer the machine name from envsetup script itself
# so we can create symlinks like
# <machine>-envsetup.sh -> envsetup.sh
# and it will automatically set MACHINE variable

arg0=$0
test -n "$BASH" && arg0=$BASH_SOURCE[0]

scriptname="${arg0##*/}"
mach=${scriptname%-*}
if [ -n "${mach}" -a "${mach}" != "${scriptname}" ]; then
  MACHINE=${mach}
fi
if [ -z "${MACHINE}" ]; then
  echo "MACHINE must be set before sourcing this script"
  return
fi
export MACHINE
echo "setting MACHINE=$MACHINE"
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
OE_BASE=$(/bin/readlink -f $(dirname '${0}'))

cd $OE_BASE

# incremement this to force recreation of config files.  This should be done
# whenever the DISTRO, or anything major changes
BASE_VERSION=10
OE_ENV_FILE=localconfig.sh

# Workaround for differences between yocto bitbake and vanilla bitbake
export BBFETCH2=True

export DISTRO_DIRNAME=$(echo $DISTRO | sed 's#[.-]#_#g')
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
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"
#--------------------------------------------------------------------------
# Make sure Bitbake doesn't filter out the following variables from our
# environment.
#--------------------------------------------------------------------------
export BB_ENV_EXTRAWHITE="MACHINE DISTRO TCLIBC TCMODE GIT_PROXY_COMMAND http_proxy ftp_proxy https_proxy all_proxy ALL_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY SDKMACHINE BB_NUMBER_THREADS OE_BASE SVS_VERSION"

#--------------------------------------------------------------------------
# Specify proxy information
#--------------------------------------------------------------------------
if [ "x$PROXYHOST" != "x" ]; then
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

if [ -z "$(readlink ${OE_BUILD_DIR}/tools/python)" ]; then
  mkdir -p ${OE_BUILD_DIR}/tools
  ln -sf /usr/bin/python2 ${OE_BUILD_DIR}/tools/python
  ln -sf /usr/bin/python2-config ${OE_BUILD_DIR}/tools/python-config
fi

#--------------------------------------------------------------------------
# If an env already exists, use it, otherwise generate it
#--------------------------------------------------------------------------

if [ -e ${OE_ENV_FILE} ]; then
  . ./${OE_ENV_FILE}
fi

if [ x"${BASE_VERSION}" != x"${SCRIPTS_BASE_VERSION}" ]; then
  echo "BASE_VERSION mismatch, recreating ${OE_ENV_FILE}"
  rm -f ${OE_ENV_FILE}

elif [ x"${DISTRO_DIRNAME}" != x"${SCRIPTS_DISTRO_DIRNAME}" ]; then
  echo "DISTRO name has changed, recreating ${OE_ENV_FILE}"
  rm -f ${OE_ENV_FILE}
fi

if [ -e ${OE_ENV_FILE} ]; then
  . ./${OE_ENV_FILE}
else

  #--------------------------------------------------------------------------
  # Specify distribution information
  #--------------------------------------------------------------------------

  echo "export SCRIPTS_BASE_VERSION=${BASE_VERSION}" >${OE_ENV_FILE}
  echo "export SCRIPTS_DISTRO_DIRNAME=\"${DISTRO_DIRNAME}\"" >>${OE_ENV_FILE}

  echo "${OE_ENV_FILE} created"

  #--------------------------------------------------------------------------
  # Write out the OE bitbake configuration file.
  #--------------------------------------------------------------------------
  mkdir -p ${OE_BUILD_DIR}/conf

  SITE_CONF=${OE_BUILD_DIR}/conf/site.conf
  cat >$SITE_CONF <<_EOF

SCONF_VERSION = "1"

# Where to store sources
DL_DIR = "${OE_BASE}/downloads"

# Where to save shared state
SSTATE_DIR = "${OE_BUILD_DIR}/build/sstate-cache"

TMPDIR = "${OE_BUILD_DIR}/build/tmp"

# Go through the Firewall
#HTTP_PROXY        = "http://${PROXYHOST}:${PROXYPORT}/"

_EOF

  echo "${SITE_CONF} has been updated"

fi # if -e ${OE_ENV_FILE}

###############################################################################
# UPDATE_ALL() - Make sure everything is up to date
###############################################################################
yoe_update_all() {
  CWD=$(pwd)
  cd ${OE_BASE}
  git pull && git submodule sync && git submodule update
  cd $CWD
}

yoe_update_all_submodules_to_master() {
  SAVEDPWD=$PWD
  cd $OE_BASE
  git submodule foreach "git checkout master && git pull"
  cd $SAVEDPWD
}

###############################################################################
# CLEAN_OE() - Delete TMPDIR
###############################################################################
yoe_clean() {
  echo "Cleaning ${OE_BUILD_TMPDIR}"
  rm -rf ${OE_BUILD_TMPDIR}
}

###############################################################################
# OE_CONFIG() - Configure OE for a target
# machine is first parameter
###############################################################################
yoe_setup() {
  SAVEDPWD=$PWD
  cd $OE_BASE
  git submodule init
  git submodule update
  cd $SAVEDPWD
}

###############################################################################
# CONFIG_SVN_PROXY() - Configure subversion proxy information
###############################################################################
yoe_config_svn_proxy() {
  if [ ! -f ${SVN_CONFIG_DIR}/servers ]; then
    mkdir -p ${SVN_CONFIG_DIR}
    cat >>${SVN_CONFIG_DIR}/servers <<_EOF
[global]
http-proxy-host = ${PROXYHOST}
http-proxy-port = ${PROXYPORT}
_EOF
  fi
}

###############################################################################
# CONFIG_GIT_PROXY() - Configure GIT proxy information
###############################################################################
yoe_config_git_proxy() {
  if [ ! -f ${GIT_CONFIG_DIR}/git-proxy.sh ]; then
    mkdir -p ${GIT_CONFIG_DIR}
    cat >${GIT_CONFIG_DIR}/git-proxy.sh <<_EOF
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

yoe_feed_server() {
  SAVEDPWD=$PWD
  cd $OE_BASE
  bitbake package-index
  cd build/tmp/deploy/ipk
  python3 -m http.server 8000
  cd $SAVEDPWD
}

yoe_setup_feed_server() {
  # set TARGET_IP in local.sh
  # set HOST_IP in local.sh if different
  if [ -n "${HOST_IP}" ]; then
    HOST_IP=$(hostname -i | cut -d' ' -f 1)
  fi
  ssh root@$MACHINE_IP ls /etc/opkg/base-feeds.conf >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "opkg is not installed, can't setup feeds on  machine $MACHINE_IP"
  else
    ssh root@$MACHINE_IP "sed -i -e 's|http://.*\/|http://$HOST_IP:8000/|' /etc/opkg/base-feeds.conf"
  fi
}

yoe_search_file() {
  if [ -z $1 ]; then
    echo "Usage: yoe_search_file filename"
    return
  fi
  cd $OE_BASE/sources
  find -name downloads -prune -o -name $1 -print
  cd -
}

yoe_search_text() {
  if test -z $1; then
    echo "Usage: yoe_search_text searchtext"
    return
  fi
  cd $OE_BASE/sources
  find -name downloads -prune -o -type f -print | xargs grep $1
  cd -
}

yoe_show_env() {
  echo "MACHINE = $MACHINE"
}

yoe_add_layer() {
  if test -z $1; then
    echo "Usage:  yoe_add_layer <url> [<branch>]"
    return
  fi
  cd $OE_BASE
  if [ -z "$2" ]; then
    br="master"
  else
    br="$2"
  fi
  n=$(echo $1 | awk -F "[/:]" '{ print $NF }')
  if [[ -e sources/$n && ! -e sources/$n/.git ]]; then
    echo "'sources/$n' already exists and is not a valid git repo"
    return
  fi
  git submodule add -b $br -f $1 sources/$n
  git submodule init sources/$n
  bitbake-layers add-layer sources/$n && sed -i -e "s|$OE_BASE|\${TOPDIR}|" conf/bblayers.conf
  echo "please commit with - git add conf/bblayers.conf && git commit -s -m'Added module $n'"
}

yoe_remove_layer() {
  if test -z $1; then
    echo "Usage:  yoe_remove_layer <layer-name>"
    return
  fi
  cd $OE_BASE
  m=sources/$1
  bitbake-layers remove-layer $1
  git submodule deinit -f $m
  git rm -r -f $m
  echo "please commit with - git add conf/bblayers.conf && git commit -s -m'Added module $n'"
  rm -rf .git/modules/$m
  #rm -rf $m
}

yoe_console() {
  # requires serial->usb device be mapped to /dev/ttyUSB_<machine name>
  # see http://bec-systems.com/site/1004/perisistent-device-names-usb-serial-ports
  screen /dev/ttyUSB_${MACHINE} 115200
}

yoe_build_all() {
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

yoe_clean_sstate() {
  $OE_BASE/sources/openembedded-core/scripts/sstate-cache-management.sh -d -y --cache-dir=$OE_BASE/build/sstate-cache
}

# Docker integration
# set DOCKER_REPO to something like yoedistro/yoe-build:stretch
# Note, set DOCKER_REPO outside of envsetup.sh, otherwise
# it will get set in container, which is not what you want.
# local.sh is a good place to set DOCKER_REPO

dkr() {
  CMD="$1"

  if [ -z "$CMD" ]; then
    echo "setting dkr action to shell"
    CMD="/bin/bash"
  fi

  SSH_AUTH_DIR=~/

  if [ -n "$SSH_AUTH_SOCK" ]; then
    SSH_AUTH_DIR=$(readlink -f $SSH_AUTH_SOCK)
  fi

  docker run --rm -it \
    -v $(pwd):$(pwd) \
    -v ~/.ssh:/home/build/.ssh \
    -v ~/.gitconfig:/home/build/.gitconfig \
    -v /stash/downloads:/stash/downloads \
    -v $SSH_AUTH_DIR:/ssh-agent \
    -e SSH_AUTH_SOCK=/ssh-agent \
    -e MACHINE=$MACHINE \
    --user $UID:$GID \
    ${DOCKER_REPO} /bin/bash -c "cd $(pwd) && . envsetup.sh && $CMD $2 $3 $4 $5 $6 $7 $8"
}

bitbake() {
  if [ -z $DOCKER_REPO ]; then
    ${OE_BASE}/sources/bitbake/bin/bitbake $@
  else
    dkr "${OE_BASE}/sources/bitbake/bin/bitbake $@"
  fi
}

###############################################################################
# Machine independent install scripts
###############################################################################

yoe_check_install_dependencies() {
  if ! pv -V 1>/dev/null; then
    echo "ERROR: Please install the pv utility (http://www.ivarch.com/programs/pv.shtml)"
    return 1
  fi
}

# write a WIC image to media (SD, USB, etc)
yoe_install_image() {
  DRIVE=$1
  IMAGE_NAME=$2

  yoe_check_install_dependencies || return 1

  if [ ! $DRIVE ] || [ ! $IMAGE_NAME ]; then
    echo "Usage: yoe_install_wic_image /dev/sdX image_name"
    echo "Warning, make sure you specify your SD card and not a workstation disk"
    echo
    return 1
  fi

  IMAGE=${OE_BASE}/build/tmp/deploy/images/${MACHINE}/${IMAGE_NAME}-${MACHINE}.wic.xz

  pv -tpreb $IMAGE | xzcat | sudo dd of=$DRIVE bs=4M iflag=fullblock oflag=direct conv=fsync
}
