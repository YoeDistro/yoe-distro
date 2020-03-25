#!/usr/bin/env bash
# the following can be used inside functions that return strings to display
# messages on console
echoerr() {
  echo $@ >&2
}

read_var_from_conf() {
  VAR_NAME=$1
  files="conf/local.conf conf/site.conf"
  for conf_file in $files; do
    if [ ! -f $conf_file ]; then
      continue
    fi

    value=$(cat $conf_file | grep "^$VAR_NAME" | awk 'BEGIN{FS="="} {print$2}' | tr -d '"' | tr -d ' ' | tail -1)
    if [ -n "$value" ]; then
      echo $value
      return 0
    fi
  done
  return 1
}

shell=$(ps -p "$$")
if [ -n "${shell##*zsh*}" ] && [ -n "${shell##*bash*}" ]; then
  echo "Error: We require running Yoe in a bash or zsh shell. Other shells have not been tested."
  return 1
fi

if [ -f local.sh ]; then
  echo "reading local settings"
  . ./local.sh
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
echo "Setting MACHINE=$MACHINE"

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
YOE_ENV_VERSION=13
YOE_ENV_FILE=localconfig.sh

# Workaround for differences between yocto bitbake and vanilla bitbake
export BBFETCH2=True

export DISTRO_DIRNAME=$(echo $DISTRO | sed 's#[.-]#_#g')
export OE_DEPLOY_DIR=${OE_BASE}/build/tmp/deploy/images/${MACHINE}

#--------------------------------------------------------------------------
# Specify the root directory for your OpenEmbedded development
#--------------------------------------------------------------------------
OE_BUILD_DIR=${OE_BASE}

CUSTOM_DL_DIR=$(read_var_from_conf 'DL_DIR')
CUSTOM_TMPDIR=$(read_var_from_conf 'TMPDIR')
CUSTOM_SSTATE_DIR=$(read_var_from_conf 'SSTATE_DIR')

if [ -n "$CUSTOM_TMPDIR" ]; then
  OE_BUILD_TMPDIR="${CUSTOM_TMPDIR}"
else
  OE_BUILD_TMPDIR="${OE_BUILD_DIR}/build/tmp"
fi

if [ -n "$CUSTOM_SSTATE_DIR" ]; then
  OE_SSTATE_DIR="${CUSTOM_SSTATE_DIR}"
else
  OE_SSTATE_DIR="${OE_BUILD_DIR}/build/sstate-cache"
fi

if [ -n "$CUSTOM_DL_DIR" ]; then
  OE_DL_DIR="${CUSTOM_DL_DIR}"
else
  OE_DL_DIR="${OE_BUILD_DIR}/downloads"
fi

OE_SOURCE_DIR=${OE_BASE}/sources

export BUILDDIR=${OE_BUILD_DIR}

mkdir -p ${OE_BUILD_DIR}
mkdir -p ${OE_BUILD_TMPDIR}
mkdir -p ${OE_DL_DIR}
mkdir -p ${OE_SSTATE_DIR}
mkdir -p ${OE_SOURCE_DIR}
export OE_BASE

#--------------------------------------------------------------------------
# Include up-to-date bitbake in our PATH.
#--------------------------------------------------------------------------
export PATH=${OE_SOURCE_DIR}/openembedded-core/scripts:${OE_SOURCE_DIR}/bitbake/bin:${PATH}
# remove duplicate entries from path
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"
#--------------------------------------------------------------------------
# Make sure Bitbake doesn't filter out the following variables from our
# environment.
#--------------------------------------------------------------------------
BB_ENV_EXTRAWHITE_OE="MACHINE DISTRO TCMODE TCLIBC HTTP_PROXY http_proxy \
HTTPS_PROXY https_proxy FTP_PROXY ftp_proxy FTPS_PROXY ftps_proxy ALL_PROXY \
all_proxy NO_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY \
SDKMACHINE BB_NUMBER_THREADS BB_NO_NETWORK PARALLEL_MAKE GIT_PROXY_COMMAND \
SOCKS5_PASSWD SOCKS5_USER SCREENDIR STAMPS_DIR BBPATH_EXTRA BB_SETSCENE_ENFORCE \
OE_BASE IMG_VERSION BUILDHISTORY_RESET YOE_PROFILE"

BB_ENV_EXTRAWHITE="$(echo $BB_ENV_EXTRAWHITE $BB_ENV_EXTRAWHITE_OE | tr ' ' '\n' | LC_ALL=C sort --unique | tr '\n' ' ')"

export BB_ENV_EXTRAWHITE
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

#--------------------------------------------------------------------------
# If an env already exists, use it, otherwise generate it
#--------------------------------------------------------------------------

if [ -e ${YOE_ENV_FILE} ]; then
  . ./${YOE_ENV_FILE}
fi

if [ x"${YOE_ENV_VERSION}" != x"${YOE_ENV_BASE_VERSION}" ]; then
  echo "YOE_ENV_VERSION mismatch, recreating ${YOE_ENV_FILE}"
  rm -f ${YOE_ENV_FILE}

elif [ x"${DISTRO_DIRNAME}" != x"${SCRIPTS_DISTRO_DIRNAME}" ]; then
  echo "DISTRO name has changed, recreating ${YOE_ENV_FILE}"
  rm -f ${YOE_ENV_FILE}
fi

if [ -e ${YOE_ENV_FILE} ]; then
  . ./${YOE_ENV_FILE}
else

  #--------------------------------------------------------------------------
  # Specify distribution information
  #--------------------------------------------------------------------------

  echo "# This is an automatically generated file, please do not edit" >${YOE_ENV_FILE}
  echo "export YOE_ENV_BASE_VERSION=${YOE_ENV_VERSION}" >>${YOE_ENV_FILE}
  echo "export SCRIPTS_DISTRO_DIRNAME=\"${DISTRO_DIRNAME}\"" >>${YOE_ENV_FILE}

  echo "${YOE_ENV_FILE} created"
fi # if -e ${YOE_ENV_FILE}

#--------------------------------------------------------------------------
# Write out the OE bitbake configuration file.
#--------------------------------------------------------------------------
mkdir -p ${OE_BUILD_DIR}/conf

AUTO_CONF=${OE_BUILD_DIR}/conf/auto.conf
rm -f $AUTO_CONF
cat >$AUTO_CONF <<_EOF
# This is an automatically generated file, please do not edit.

ACONF_VERSION = "1"

# Where to store sources
DL_DIR = "${OE_DL_DIR}"

# Where to save shared state
SSTATE_DIR = "${OE_SSTATE_DIR}"

TMPDIR = "${OE_BUILD_TMPDIR}"

# Go through the Firewall
#HTTP_PROXY        = "http://${PROXYHOST}:${PROXYPORT}/"

MACHINE ?= "$MACHINE"
_EOF

echo "${AUTO_CONF} has been updated"

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
  bitbake package-index || return 1
  cd build/tmp/deploy/ipk
  python3 -m http.server 8000
  cd $SAVEDPWD
}

yoe_host_ip() {
  hostname -i | cut -d' ' -f 1
}

yoe_setup_feed_server() {
  if [ -n "$1" ]; then
    MIP=$1
  else
    if [ -z "$MACHINE_IP" ]; then
      echo
      echo "Error: Machine IP address not given"
      echo "Usage: yoe_setup_feed_server <machine ip>"
      echo " or set the MACHINE_IP env variable"
      echo
      return 1
    fi
    MIP=$MACHINE_IP
  fi
  # set TARGET_IP in local.sh
  # set HOST_IP in local.sh if different
  if [ -z "${HOST_IP}" ]; then
    HOST_IP=$(hostname -i | cut -d' ' -f 1)
  fi
  ssh root@$MIP ls /etc/opkg/base-feeds.conf >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "opkg is not installed, can't setup feeds on  machine $MIP"
  else
    SERVER=http://$HOST_IP:8000
    echo "pointing feeds to $SERVER"
    ssh root@$MIP "sed -i -e 's|http://.*\/|${SERVER}/|' /etc/opkg/base-feeds.conf"
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
  MACHINES="raspberrypi3 beaglebone"
  for m in $MACHINES; do
    echo "=========================="
    echo "Building $m ....."
    export MACHINE=$m
    if ! bitbake yoe-simple-image; then
      return
    fi
  done
}

yoe_clean_sstate() {
  $OE_BASE/sources/openembedded-core/scripts/sstate-cache-management.sh -d -y --cache-dir=$OE_BASE/build/sstate-cache
}

# Docker integration
# set DOCKER_REPO to something like yoedistro/yoe-build:buster
# DOCKER_REPO can be set in scripts that wrap envsetup.sh
# set DOCKER_REPO to 'none' to disable docker

if [ -z "$DOCKER_REPO" ]; then
  echo "Setting DOCKER_REPO to yoedistro/yoe-build:buster"
  export DOCKER_REPO=yoedistro/yoe-build:buster
fi

# if we are building using docker, we don't really care what /bin/sh is since the Yoe docker images defaults
# to using bash for /bin/sh. If user is building in their host system, then require that /bin/sh be bash
if [ "$DOCKER_REPO" = "none" ]; then
  if [ "$(readlink /bin/sh)" != "bash" ]; then
    echo "ERROR: /bin/sh should point to bash, other shells (such as dash) have not been extensively tested"
    echo "on Ubuntu/debian, try: sudo dpkg-reconfigure dash"
    return 1
  fi
fi

check_docker() {
  if ! docker -v >/dev/null 2>&1; then
    echo "Error, please install docker or set DOCKER_REPO=none in environment"
    return 1
  fi

  if ! docker images -q $DOCKER_REPO >/dev/null 2>&1; then
    echo "Error, docker image $DOCKER_REPO not installed"
    echo "Please install it with: docker pull $DOCKER_REPO"
    return 1
  fi

  return 0
}

dkr() {
  check_docker || return 1

  if [ -z "$1" ]; then
    echo "setting dkr action to shell"
    CMD="/bin/bash"
  else
    CMD=". ${OE_BASE}/envsetup.sh && $1"
    shift
  fi
  if [ "$DOCKER_PSEUDO_TTY" = "no" ]; then
    PSEUDO_TTY=""
  else
    PSEUDO_TTY="-t"
  fi
  if [ -z "$DOCKER_FORWARD_VNC" ]; then
    VNC_PORT=""
  else
    VNC_PORT="-p 5900:5900"
  fi

  SSH_AUTH_DIR=~/

  unset MAP_DL_DIR
  unset MAP_TMPDIR
  unset MAP_SSTATE_DIR
  unset MAP_GITCONFIG
  MAP_TMPDIR="-v $(readlink -f $OE_BUILD_TMPDIR):$(readlink -f $OE_BUILD_TMPDIR)"
  MAP_DL_DIR="-v $(readlink -f $OE_DL_DIR):$(readlink -f $OE_DL_DIR)"
  MAP_SSTATE_DIR="-v $(readlink -f $OE_SSTATE_DIR):$(readlink -f $OE_SSTATE_DIR)"

  if [ -n "$SSH_AUTH_SOCK" ]; then
    SSH_AUTH_DIR=$(readlink -f $SSH_AUTH_SOCK)
  fi

  if [ -e ~/.gitconfig ]; then
    MAP_GITCONFIG="-v $HOME/.gitconfig:/home/build/.gitconfig"
  fi

  docker run --rm -i $PSEUDO_TTY \
    -v ${OE_BASE}:${OE_BASE} \
    -v ~/.ssh:/home/build/.ssh \
    $MAP_GITCONFIG \
    $MAP_DL_DIR \
    $MAP_SSTATE_DIR \
    $MAP_TMPDIR \
    -v $SSH_AUTH_DIR:/ssh-agent \
    -e SSH_AUTH_SOCK=/ssh-agent \
    -e MACHINE=$MACHINE \
    -w ${OE_BASE} \
    --user $(id -u):$(id -g) \
    $VNC_PORT \
    ${DOCKER_REPO} /bin/bash -c "$CMD $@"
}

bitbake() {
  ulimit -n 4096
  if [ -z $DOCKER_REPO ] || [ "$DOCKER_REPO" = "none" ]; then
    ${OE_BASE}/sources/bitbake/bin/bitbake $@
  else
    dkr "${OE_BASE}/sources/bitbake/bin/bitbake $@"
  fi
}

devtool() {
  ulimit -n 4096
  if [ -z $DOCKER_REPO ] || [ "$DOCKER_REPO" = "none" ]; then
    ${OE_BASE}/sources/openembedded-core/scripts/devtool $@
  else
    dkr "${OE_BASE}/sources/openembedded-core/scripts/devtool $@"
  fi
}

yoe_get_image_version() {
  echo $(read_var_from_conf 'IMG_VERSION')
}

###############################################################################
# Machine independent install scripts
###############################################################################

yoe_check_install_dependencies() {
  if ! command -v bmaptool >&/dev/null; then
    echo "bmaptool not installed"
    echo "Install bmap-tools package on build host"
    echo "debian-like - sudo apt install bmap-tools"
    echo "Fedora like rpm-based - sudo dnf install bmap-tools"
    echo "archlinux - yay bmap-tools"
    return 1
  fi
}

# write a WIC image to media (SD, USB, etc)
yoe_install_image() {
  DRIVE=$1
  IMAGE_NAME=$2
  yoe_check_install_dependencies || return 1

  if [ ! $DRIVE ] || [ ! $IMAGE_NAME ]; then
    echo "Usage: yoe_install_image /dev/sdX image_name"
    echo "WARNING!!!, make sure you specify your SD card and not a workstation disk"
    echo
    return 1
  fi
  WICIMG="$IMAGE"
  if [ -z $WICIMG ]; then
    WICIMG=${OE_BASE}/build/tmp/deploy/images/${MACHINE}/${IMAGE_NAME}-${MACHINE}.wic.xz
  fi
  if [ ! -e $WICIMG ]; then
    echo "$WICIMG does not exist, please build the image first"
    echo
    unset WICIMG
    return 1
  fi
  bmaptool copy ${WICIMG} ${DRIVE}
  if [ $? != 0 ]; then
    echo "Please make sure\n"
    echo "1. disk is inserted and discovered as ${DRIVE}"
    echo "2. run 'sudo chmod 666 ${DRIVE}'"
    echo "3. re-run yoe_install_image command"
  fi
  unset WICIMG
}
