#
# Distro Settings
#
DISTRO_NAME = "Yoe Linux"
MAINTAINER = "Yoe Distro Community <http://yoedistro.org>"
TARGET_VENDOR = "-yoe"
SDK_VENDOR = "-yoesdk"
# Distro version is YYYY.MM
DISTRO_VERSION = "2023.09"
DISTRO_CODENAME = "Galway"
SDK_VERSION := "${DISTRO_VERSION}"

SDK_NAME_PREFIX = "yoe"
SDK_NAME = "${SDK_NAME_PREFIX}-${SDKMACHINE}-${IMAGE_BASENAME}-${TUNE_PKGARCH}-${MACHINE}"
SDKPATHINSTALL = "/opt/${DISTRO}/${SDK_VERSION}"
SDKEXTPATH = "~/${SDK_NAME_PREFIX}_sdk/${DISTRO_VERSION}"
SDK_INCLUDE_NATIVESDK = "1"

DISTRO_VERSION[vardepsexclude] = "DATE"
SDK_VERSION[vardepsexclude] = "DATE"

PREMIRRORS ??= "\
bzr://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
cvs://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
git://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
gitsm://.*/.* http://downloads.yoctoproject.org/mirror/sources/ \n \
hg://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n \
osc://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n \
p4://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n \
svn://.*/.*   http://downloads.yoctoproject.org/mirror/sources/ \n"

MIRRORS =+ "\
ftp://.*/.*      http://downloads.yoctoproject.org/mirror/sources/ \n \
http://.*/.*     http://downloads.yoctoproject.org/mirror/sources/ \n \
https://.*/.*    http://downloads.yoctoproject.org/mirror/sources/ \n"

# Allow reusing DL_DIR from the current build as a mirror for other builds.
BB_GENERATE_MIRROR_TARBALLS = "1"

# Template for feed server
PACKAGE_FEED_URIS ??= "http://<feedserver>:8000/"

# Use Hash Equivalence
BB_SIGNATURE_HANDLER = "OEEquivHash"
# Start a local hashserver instance
BB_HASHSERVE = "auto"
#BB_HASHSERVE_UPSTREAM = "hashserv.yocto.io:8687"
#SSTATE_MIRRORS ?= "file://.*  https://cdn.jsdelivr.net/yocto/sstate/all/PATH;downloadfilename=PATH"
# see https://docs.yoctoproject.org/bitbake/2.0/bitbake-user-manual/bitbake-user-manual-ref-variables.html#term-BB_GIT_SHALLOW
BB_GIT_SHALLOW = "1"

# Keep only the top commit
BB_GIT_SHALLOW_DEPTH = "1"

# This defaults to enabled if both BB_GIT_SHALLOW and
# BB_GENERATE_MIRROR_TARBALLS are enabled
BB_GENERATE_SHALLOW_TARBALLS = "1"

PRSERV_HOST ?= "localhost:0"
TCLIBCAPPEND = ""

BUILDHISTORY_COMMIT ?= "1"

# Do not use verbose logs for cmake, this reduces build logs significantly, for recipes
# e.g. qtwebkit from 163M down to < 1M
CMAKE_VERBOSE ?= ""

# account for some layers which have bbappends for layers we dont include
BB_DANGLINGAPPENDS_WARNONLY = "1"

# Use clang as default compiler
TOOLCHAIN ?= "clang"

# Build clang into SDK as well
CLANGSDK = "1"

# Use compile-rt/libcxx/libunwind as default runtime libraries
TC_CXX_RUNTIME ?= "llvm"
RUNTIME ?= "llvm"

# QA check settings - a little stricter than the OE-Core defaults
WARN_TO_ERROR_QA ?= "\
            libdir xorg-driver-abi \
            textrel incompatible-license files-invalid \
            infodir build-deps src-uri-bad symlink-to-sysroot multilib \
            invalid-packageconfig host-user-contaminated uppercase-pn patch-fuzz \
            mime mime-xdg unlisted-pkg-lics unhandled-features-check \
            missing-update-alternatives native-last \
            "

WARN_QA:remove = "${WARN_TO_ERROR_QA}"
ERROR_QA:append = " ${WARN_TO_ERROR_QA}"
# Yoe does not build binary feeds, this build QA error breaks builds unnessarily
ERROR_QA:remove = "version-going-backwards"
#
# Additional image features
#
# The following is a list of additional classes to use when building images which
# enable extra features. Some available options which can be included in this variable
# are:
#   - 'buildstats' collect build statistics
#   - 'image-swab' to perform host system intrusion detection
USER_CLASSES ?= "buildhistory buildstats buildstats-summary"

IMAGE_CLASSES += "testimage testsdk"

require conf/distro/include/no-static-libs.inc
require conf/distro/include/yocto-uninative.inc
require conf/distro/include/security_flags.inc

INHERIT += "${@bb.utils.contains('BUILD_ARCH', 'ppc64le', '', 'uninative', d)}"

# Add /etc/build to every image
INHERIT += "image-buildinfo"

DISTRO_FEATURES:append = " opengl multiarch wayland pam vulkan usrmerge ld-is-lld"
# lld does not work with objects created with gas from binutils 2.41 yet
# see https://reviews.llvm.org/D142880
DISTRO_FEATURES:remove:riscv64 = "ld-is-lld"
DISTRO_FEATURES:remove:riscv32 = "ld-is-lld"

#PREFERRED_PROVIDER_pkgconfig = "pkgconf"
#PREFERRED_PROVIDER_pkgconfig-native = "pkgconf-native"
#PREFERRED_PROVIDER_nativesdk-pkgconfig = "nativesdk-pkgconf"

PREFERRED_PROVIDER_llvm = "clang"
PREFERRED_PROVIDER_llvm-native = "clang-native"
PREFERRED_PROVIDER_nativesdk-llvm = "nativesdk-clang"
PROVIDES:pn-clang = "llvm"
PROVIDES:pn-clang-native = "llvm-native"
PROVIDES:pn-nativesdk-clang = "nativesdk-llvm"

PREFERRED_PROVIDER_virtual/libgl ??= "mesa"
PREFERRED_PROVIDER_virtual/libgl-native ?= "mesa-native"
PREFERRED_PROVIDER_libgl-native = "mesa-native"
PREFERRED_PROVIDER_virtual/psplash ??= "psplash"
PREFERRED_PROVIDER_psplash-support ??= "psplash"
PREFERRED_PROVIDER_jpeg ??= "libjpeg-turbo"
PREFERRED_PROVIDER_jpeg-native ??= "libjpeg-turbo-native"
PREFERRED_PROVIDER_grub-efi-native ??= "grub-efi-native"
PREFERRED_PROVIDER_u-boot-fw-utils ??= "libubootenv"
PREFERRED_PROVIDER_u-boot ??= "u-boot"

PREFERRED_RPROVIDER_ssh ??= "openssh"

# This helps in using imx specific provider when building for imx platforms, otherwise
# it uses the oe-core versions
IMX_DEFAULT_BOOTLOADER ??= "u-boot"
PREFERRED_PROVIDER_u-boot-tools-native ??= "${IMX_DEFAULT_BOOTLOADER}-tools-native"
PREDERRED_PROVIDED_nativesdk-u-boot-tools ??= "${IMX_DEFAULT_BOOTLOADER}-tools-native"
PREFERRED_PROVIDER_u-boot-mkimage-native ??= "${IMX_DEFAULT_BOOTLOADER}-tools-native"
PREFERRED_PROVIDER_nativesdk-u-boot-mkimage ??= "nativesdk-${IMX_DEFAULT_BOOTLOADER}-tools"

# wpe backend selection, wpebackend-fdo, wpebackend-mesa, wpebackend-rdk
#
PREFERRED_PROVIDER_virtual/wpebackend ??= "wpebackend-fdo"

# Disable qt in wpe
PACKAGECONFIG:remove:pn-wpewebkit = "qtwpe"

# Pin versions, some BSP layers are housing older versions and have higher BBFILE_PRIORITY
# as a result DEFAULT_PREFERENCE = "-1" does not help either so pin it here
# meta-atmel has 3.0.8
PREFERRED_VERSION_swig = "4%"
PREFERRED_VERSION_swig-native = "4%"
PREFERRED_VERSION_nativesdk-swig = "4%"

# the following is required because some BSP layers (fsl) don't set this, and then
# other BSP layers fail bitbake parsing (ti).
MACHINE_KERNEL_PR = "0"

# swupdate initramfs init system
SWUPDATE_INIT = "tiny"

# Use 1GB DRAM for QEMU machines, helps in running tests
QB_MEM = "-m 1024"

# Use zstd compression instead of xz default in opkg
# See https://lists.openembedded.org/g/openembedded-core/message/170650?p=%2C%2C%2C20%2C0%2C0%2C0%3A%3Acreated%2C0%2Copkg%2C20%2C2%2C0%2C93654146
OPKGBUILDCMD = 'opkg-build -Z zstd -a "--threads=${ZSTD_THREADS}"'

# The two lines below enable SDL frontend for qemu
# default is VNC
PACKAGECONFIG:append:pn-qemu-native = " sdl"
PACKAGECONFIG:append:pn-nativesdk-qemu = " sdl"

# Dont package kernel into image
RDEPENDS:${KERNEL_PACKAGE_NAME}-base = ""

# Enable persistent logs across reboots
VOLATILE_LOG_DIR = "no"

SKIP_RECIPE[build-appliance-image] = "tries to include whole downloads directory in /home/builder/poky :/"
SKIP_RECIPE[smartrefrigerator] = "Needs porting to QT > 5.6"
SKIP_RECIPE[qmlbrowser] = "Needs porting to QT > 5.6"
SKIP_RECIPE[minehunt] = "Needs porting to QT > 5.6"
SKIP_RECIPE[homeautomation] = "Needs porting to QT > 5.6"
SKIP_RECIPE[samegame] = "Needs porting to QT > 5.6"
SKIP_RECIPE[applicationlauncher] = "Needs porting to QT > 5.6"
SKIP_RECIPE[spacetouch] = "Needs porting to libplanes 1.0"
SKIP_RECIPE[qtviewplanes] = "Needs porting to libplanes 1.0"
SKIP_RECIPE[egt-thermostat] = "Needs porting to egt 0.8.2+"
SKIP_RECIPE[bigbuckbunny-1080p] = "big and doesn't really need to be tested so much"
SKIP_RECIPE[bigbuckbunny-480p] = "big and doesn't really need to be tested so much"
SKIP_RECIPE[bigbuckbunny-720p] = "big and doesn't really need to be tested so much"
SKIP_RECIPE[tearsofsteel-1080p] = "big and doesn't really need to be tested so much"
SKIP_RECIPE[python3-pyqt5] = "needs re-work  to build with sip3"
SKIP_RECIPE[python3-pyqtchart] = "needs python3-pyqt5 which needs reworked to work with sip3"

RDEPENDS:packagegroup-meta-multimedia:remove:pn-packagegroup-meta-multimedia = "bigbuckbunny-1080p bigbuckbunny-480p bigbuckbunny-720p tearsofsteel-1080p"
RDEPENDS:packagegroup-meta-oe-fortran-packages:remove:pn-packagegroup-meta-oe = "lapack octave suitesparse"
RDEPENDS:packagegroup-meta-python3:remove:pn-packagegroup-meta-python = "python3-cvxopt"
