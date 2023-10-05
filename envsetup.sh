#!/usr/bin/env bash
# the following can be used inside functions that return strings to display
# messages on console
# this file should be sourced (.), not run as a script
echoerr() {
  echo $@ >&2
}

# List supported projects
yoe_get_projects() {
    (
    cd $OE_BASE/conf/projects
    for f in *; do
        if [ -e $f/config.conf ]; then
            echo $f
        fi
    done
    )
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

usage() {
  echo
  echo "Usage:"
  echo ". $arg0 <project>"
  echo
  echo "Please specify one of the following projects"
  echo
  yoe_get_projects
  echo
  return 0
}

shell=$(ps -p "$$")
if [ -n "${shell##*zsh*}" ] && [ -n "${shell##*bash*}" ]; then
  echo "Error: We require running Yoe in a bash or zsh shell. Other shells have not been tested."
  return 1
fi

DOCKER="docker"

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

if [ -n "$BASH" ]; then
    arg0=$BASH_SOURCE[0]
elif [ -n "$ZSH_NAME" ]; then
    arg0=$0
else
    arg0="$(pwd)/envsetup.sh"
    if [ ! -e "$arg0" ]; then
        echo "Error: $arg0 doesn't exist!" >&2
        echo "Please source this script in same directory where $arg0 lives" >&2
        exit 1
    fi
fi

if [ -z "$ZSH_NAME" ] && [ "$0" = "$arg0" ]; then
    echo "Error: This script needs to be sourced. Please run as '. $arg0'" >&2
    exit 1
fi

###############################################################################
# OE_BASE    - The root directory for all OE sources and development.
###############################################################################
OE_BASE=$(readlink -f $(dirname $arg0))

cd $OE_BASE

if [ $# -eq 0 -a -z $PROJECT ]; then
  usage
fi

if [ $# -gt 0 ]; then
  PROJECT=$1
fi

projects="`yoe_get_projects | tr '\n' ' '`"

echo "$projects" | grep -q "\<$PROJECT\>" >&2

if [ $? != 0 ]; then
  echo
  echo "'$PROJECT' is not yet a supported project"
  echo "Please unset PROJECT environment variable or set it to a supported project"
  usage
  unset PROJECT
  unset MACHINE
  return 1
fi

export PROJECT
echo "Setting PROJECT=$PROJECT"

MACHINE=`cat conf/projects/$PROJECT/config.conf | grep '^MACHINE.*=' | cut -d '"' -f 2`

if [ -z "$MACHINE" ]; then
  MACHINE=`cat conf/projects/$PROJECT/config.conf | grep '^MACHINE.*=' | cut -d "'" -f 2`
fi

if [ -z "$MACHINE" ]; then
  echo "Please define MACHINE = \"<name>\" in conf/projects/$PROJECT/config.conf"
  unset PROJECT
  unset MACHINE
  return 1
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
export PATH=${OE_SOURCE_DIR}/poky/scripts:${OE_SOURCE_DIR}/poky/bitbake/bin:${OE_BUILD_TMPDIR}/sysroots/`uname -m`/usr/bin:${PATH}
# remove duplicate entries from path
export PATH="$(perl -e 'print join(":", grep { not $seen{$_}++ } split(/:/, $ENV{PATH}))')"
#--------------------------------------------------------------------------
# Make sure Bitbake doesn't filter out the following variables from our
# environment.
#--------------------------------------------------------------------------
BB_ENV_PASSTHROUGH_ADDITIONS_OE="MACHINE DISTRO TCMODE TCLIBC HTTP_PROXY http_proxy \
HTTPS_PROXY https_proxy FTP_PROXY ftp_proxy FTPS_PROXY ftps_proxy ALL_PROXY \
all_proxy NO_PROXY no_proxy SSH_AGENT_PID SSH_AUTH_SOCK BB_SRCREV_POLICY \
SDKMACHINE BB_NUMBER_THREADS BB_NO_NETWORK PARALLEL_MAKE GIT_PROXY_COMMAND \
SOCKS5_PASSWD SOCKS5_USER SCREENDIR STAMPS_DIR BBPATH_EXTRA BB_SETSCENE_ENFORCE \
OE_BASE IMG_VERSION BUILDHISTORY_RESET YOE_PROFILE DOCKER PROJECT"

BB_ENV_PASSTHROUGH_ADDITIONS="$(echo $BB_ENV_PASSTHROUGH_ADDITIONS $BB_ENV_PASSTHROUGH_ADDITIONS_OE | tr ' ' '\n' | LC_ALL=C sort --unique | tr '\n' ' ')"

export BB_ENV_PASSTHROUGH_ADDITIONS
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
export BBPATH=${OE_BUILD_DIR}:${OE_SOURCE_DIR}/poky/meta${BBPATH_EXTRA}

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
  hostname -i
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
    HOST_IP=$(yoe_host_ip)
  fi
  ssh "root@$MIP" ls /etc/opkg/base-feeds.conf >/dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "opkg is not installed, can't setup feeds on  machine $MIP"
  else
    SERVER=http://$HOST_IP:8000
    echo "pointing feeds to $SERVER"
    ssh "root@$MIP" "sed -i -e 's|http://.*\/|${SERVER}/|' /etc/opkg/base-feeds.conf"
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
  echo "Add it from project layers.conf files in conf/projects"
  echo "please commit with - git commit -s -m'Add module $n'"
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
  echo "Remove it from project layers.conf files in conf/projects"
  echo "please commit with - git commit -s -m'Remove module $n'"
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
  $OE_BASE/sources/poky/scripts/sstate-cache-management.sh -d -y --cache-dir=$OE_BASE/build/sstate-cache
}

# Docker integration
# set DOCKER_REPO to something like yoedistro/yoe-build:bookworm-x86_64
# DOCKER_REPO can be set in scripts that wrap envsetup.sh
# set DOCKER_REPO to 'none' to disable docker

if [ -z "$DOCKER_REPO" ]; then
  if [ "`uname`" = "Darwin" -a "`uname -m`" = "arm64" ]; then
    dockerarch="-aarch64"
    elif [ "`uname`" = "Linux" ]; then
    dockerarch="-`uname -m`"
  fi
  echo "Setting DOCKER_REPO to yoedistro/yoe-build:bookworm${dockerarch}"
  export DOCKER_REPO=yoedistro/yoe-build:bookworm${dockerarch}
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
  if ! $DOCKER -v >/dev/null 2>&1; then
    echo "Error, please install docker or set DOCKER_REPO=none in environment"
    return 1
  fi

  if ! $DOCKER images -q $DOCKER_REPO >/dev/null 2>&1; then
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
    CMD=". ${OE_BASE}/envsetup.sh $PROJECT 2>&1 > /dev/null && \
      DOCKER_REPO=none /bin/bash && . ./envsetup.sh"
  else
    CMD=". ${OE_BASE}/envsetup.sh $PROJECT 2>&1 > /dev/null && $@"
    shift
  fi
  if [ "$DOCKER_PSEUDO_TTY" = "no" ]; then
    PSEUDO_TTY=""
  else
    PSEUDO_TTY="--tty"
  fi
  if [ -n "$DOCKER_PORTS" ]; then
    unset PORTMAPS
    for p in $DOCKER_PORTS; do
      PORTMAPS="$PORTMAPS --publish $p"
    done
  fi

  SSH_AUTH_DIR=~/

  unset MAP_DL_DIR
  unset MAP_TMPDIR
  unset MAP_SSTATE_DIR
  unset MAP_GITCONFIG
  MAP_TMPDIR="--volume=$(readlink -f $OE_BUILD_TMPDIR):$(readlink -f $OE_BUILD_TMPDIR)"
  MAP_DL_DIR="--volume=$(readlink -f $OE_DL_DIR):$(readlink -f $OE_DL_DIR)"
  MAP_SSTATE_DIR="--volume=$(readlink -f $OE_SSTATE_DIR):$(readlink -f $OE_SSTATE_DIR)"

  if [ -n "$SSH_AUTH_SOCK" ]; then
    SSH_AUTH_DIR=$(readlink -f $SSH_AUTH_SOCK)
  fi

  if [ -e ~/.gitconfig ]; then
    MAP_GITCONFIG="--volume=$HOME/.gitconfig:/home/build/.gitconfig"
  fi

  GGID=$(id -g)
  UUID=$(id -u)
  UID_ARGS=""
  if [ "$DOCKER" = "podman" ]; then
    # Running with namespace and overlay-fs labelling enabled introduces a
    # significant delay in podman startup when the build directory contains
    # giga-bytes of data, so for now, disable default namespacing and provide
    # our own.
    # Running without namespace mapping as non-root
    # https://github.com/containers/podman/issues/2180
    UID_ARGS="--privileged \
      --uidmap $UUID:0:1 \
      --uidmap 0:1:$UUID \
      --gidmap $GGID:0:1 \
      --gidmap 0:1:$GGID \
      --net=slirp4netns:port_handler=slirp4netns \
      --security-opt seccomp=unconfined \
      --security-opt label=disable \
      --cap-add=NET_RAW \
      "
  fi

  if [ -c /dev/kvm ]; then
    DOCKER_ENABLE_KVM="--device /dev/kvm"
  else
    DOCKER_ENABLE_KVM=""
  fi

  $DOCKER run --rm -i $PSEUDO_TTY \
    -v ${OE_BASE}:${OE_BASE} \
    -v ~/.ssh:/home/build/.ssh \
    $MAP_GITCONFIG \
    $MAP_DL_DIR \
    $MAP_SSTATE_DIR \
    $MAP_TMPDIR \
    -v $SSH_AUTH_DIR:/ssh-agent \
    -e SSH_AUTH_SOCK=/ssh-agent \
    -e MACHINE=$MACHINE \
    -e PROJECT=$PROJECT \
    -w ${OE_BASE} \
    --env GGID=$(id -g) \
    --env UUID=$(id -u) \
    $PORTMAPS \
    $UID_ARGS \
    $DOCKER_EXTRA_ARGS \
    --cap-add=NET_ADMIN \
    --device /dev/net/tun \
    ${DOCKER_ENABLE_KVM} \
    --device /dev/vhost-net \
    ${DOCKER_REPO} /bin/bash -c "$CMD"
}

wrapcmd() {
  ulimit -n 4096
  cmd=$1
  shift
  if [ -z $DOCKER_REPO ] || [ "$DOCKER_REPO" = "none" ]; then
    $cmd $@
  else
    dkr "$cmd $@"
  fi
}

bitbake() {
  wrapcmd ${OE_BASE}/sources/poky/bitbake/bin/bitbake $@
}
bitbake-diffsigs() {
  wrapcmd ${OE_BASE}/sources/poky/bitbake/bin/bitbake-diffsigs $@
}

bitbake-dumpsig() {
  wrapcmd ${OE_BASE}/sources/poky/bitbake/bin/bitbake-dumpsig $@
}

bitbake-getvar() {
  wrapcmd ${OE_BASE}/sources/poky/bitbake/bin/bitbake-getvar $@
}

bitbake-layers() {
  wrapcmd ${OE_BASE}/sources/poky/bitbake/bin/bitbake-layers $@
}

bitbake-selftest() {
  wrapcmd ${OE_BASE}/sources/poky/bitbake/bin/bitbake-selftest $@
}

devtool() {
  wrapcmd ${OE_BASE}/sources/poky/scripts/devtool $@
}

oe-pkgdata-util() {
  wrapcmd ${OE_BASE}/sources/poky/scripts/oe-pkgdata-util $@
}

recipetool() {
  wrapcmd ${OE_BASE}/sources/poky/scripts/recipetool $@
}


yoe_get_image_version() {
  echo $(read_var_from_conf 'IMG_VERSION')
}

###############################################################################
# Machine independent install scripts
###############################################################################

yoe_check_install_dependencies() {
  if ! command -v bmaptool >&/dev/null; then
    # build own copy of native tools
    bitbake bmap-tools-native build-sysroots
    if ! command -v bmaptool >&/dev/null; then
      echo "bmaptool not installed"
      echo "Install bmap-tools package on build host"
      echo "debian-like - sudo apt install bmap-tools"
      echo "Fedora like rpm-based - sudo dnf install bmap-tools"
      echo "archlinux - yay bmap-tools"
      return 1
    fi
  fi
}

# write a WIC image to media (SD, USB, etc)
yoe_install_image() {
  DRIVE=$1
  IMAGE_NAME=$2

  if [ -n "$IMAGE_NAME" ]; then
    WICIMG=${OE_BASE}/build/tmp/deploy/images/${MACHINE}/${IMAGE_NAME}-${MACHINE}.rootfs.wic.xz
  else
    echo "no image specified -- installing default installer image ..."
    WICIMG=${OE_BASE}/build/tmp/deploy/images/${MACHINE}/yoe-installer-image-${MACHINE}.rootfs.wic.xz
  fi

  yoe_check_install_dependencies || return 1

  if [ ! "$DRIVE" ]; then
    echo "Usage: yoe_install_image /dev/sdX image_name"
    echo "WARNING!!!, make sure you specify your SD card and not a workstation disk"
    echo
    return 1
  fi

  if [ ! -e "$WICIMG" ]; then
    echo "$WICIMG does not exist, please build the image first"
    echo
    unset WICIMG
    return 1
  fi
  if ! bmaptool copy "${WICIMG}" "${DRIVE}"; then
    printf "Please make sure\n"
    echo "1. disk is inserted and discovered as ${DRIVE}"
    echo "2. run 'sudo chmod 666 ${DRIVE}'"
    echo "3. disk is not mounted: umount ${DRIVE}*"
    echo "4. re-run yoe_install_image command"
  fi
  unset WICIMG
}

# Needed for running per-image ptest images in parallel on qemu
yoe_create_tap_devices() {
  if [ ! -e ${OE_BASE}/sources/poky/scripts/runqemu-gen-tapdevs ]; then
    bitbake qemu-helper-native
  fi
  sudo ${OE_BASE}/sources/poky/scripts/runqemu-gen-tapdevs `id -g` `nproc --all`
}
