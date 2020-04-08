#
# Distro Settings
#
DISTRO_NAME = "Yoe Linux"
MAINTAINER = "Yoe Distro Community <http://yoedistro.org>"
TARGET_VENDOR = "-yoe"
SDK_VENDOR = "-yoesdk"
# Distro version keep it up with Yocto release
DISTRO_VERSION = "3.1"
DISTRO_CODENAME = "argali"
SDK_VERSION := "${DISTRO_VERSION}"

SDK_NAME_PREFIX = "yoe"
SDK_NAME = "${SDK_NAME_PREFIX}-${SDKMACHINE}-${IMAGE_BASENAME}-${TUNE_PKGARCH}-${MACHINE}"
SDKPATH = "/opt/${SDK_NAME_PREFIX}/${SDK_VERSION}"
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

# The CONNECTIVITY_CHECK_URI's are used to test whether we can succesfully
# fetch from the network (and warn you if not). To disable the test set
# the variable to be empty.
# Git example url: git://git.yoctoproject.org/yocto-firewall-test;protocol=git;rev=master
CONNECTIVITY_CHECK_URIS ?= "https://www.example.com/"

PRSERV_HOST = "localhost:0"
TCLIBCAPPEND = ""

BUILDHISTORY_COMMIT ?= "1"

# Do not use verbose logs for cmake, this reduces build logs significantly, for recipes
# e.g. qtwebkit from 163M down to < 1M
CMAKE_VERBOSE ?= ""

# the following is required because some BSP layers (fsl) don't set this, and then
# other BSP layers fail bitbake parsing (ti).
MACHINE_KERNEL_PR ??= "0"

# accound for some layers which have bbappends for layers we dont include
BB_DANGLINGAPPENDS_WARNONLY = "1"

# Poky goodness
# QA check settings - a little stricter than the OE-Core defaults

WARN_TO_ERROR_QA = "ldflags useless-rpaths rpaths staticdev libdir xorg-driver-abi \
            textrel already-stripped incompatible-license files-invalid \
            installed-vs-shipped compile-host-path install-host-path \
            pn-overrides infodir build-deps src-uri-bad \
            unknown-configure-option symlink-to-sysroot multilib \
            invalid-packageconfig host-user-contaminated uppercase-pn patch-fuzz \
            mime mime-xdg \
            "
WARN_QA_remove = "${WARN_TO_ERROR_QA}"
ERROR_QA_append = " ${WARN_TO_ERROR_QA}"
#ERROR_QA_remove  = "split-strip"
#
# Additional image features
#
# The following is a list of additional classes to use when building images which
# enable extra features. Some available options which can be included in this variable
# are:
#   - 'buildstats' collect build statistics
#   - 'image-mklibs' to reduce shared library files size for an image
#   - 'image-prelink' in order to prelink the filesystem image
#   - 'image-swab' to perform host system intrusion detection
# NOTE: if listing mklibs & prelink both, then make sure mklibs is before prelink
# NOTE: mklibs also needs to be explicitly enabled for a given image, see local.conf.extended
# image-prelink sometimes disabled due to issues with IFUNC symbol relocation
USER_CLASSES ?= "buildstats buildhistory buildstats-summary image-mklibs image-prelink"

IMAGE_CLASSES += "testimage testsdk"

require conf/distro/include/no-static-libs.inc
require conf/distro/include/yocto-uninative.inc
require conf/distro/include/security_flags.inc

INHERIT += "${@bb.utils.contains('BUILD_ARCH', 'ppc64le', '', 'uninative', d)}"

# Add /etc/build to every image
INHERIT += "image-buildinfo"

DISTRO_FEATURES_append = " largefile opengl multiarch wayland pam polkit "

#PREFERRED_PROVIDER_pkgconfig = "pkgconf"
#PREFERRED_PROVIDER_pkgconfig-native = "pkgconf-native"
#PREFERRED_PROVIDER_nativesdk-pkgconfig = "nativesdk-pkgconf"

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
PACKAGECONFIG_remove_pn-wpewebkit = "qtwpe"

# Pin versions, some BSP layers are housing older versions and have higher BBFILE_PRIORITY
# as a result DEFAULT_PREFERENCE = "-1" does not help either so pin it here
PREFERRED_VERSION_swig = "3.0.12"
PREFERRED_VERSION_swig-native = "3.0.12"
PREFERRED_VERSION_swig-nativesdk = "3.0.12"

# the following is required because some BSP layers (fsl) don't set this, and then
# other BSP layers fail bitbake parsing (ti).
MACHINE_KERNEL_PR = "0"

# Enable u-boot for RPI
RPI_USE_U_BOOT = "1"

# Disable rpi raimbow screen
DISABLE_SPLASH = "1"

# swupdate initramfs init system
SWUPDATE_INIT = "tiny"

# we want to have boot + rootfs ( that can grow )
WKS_FILE_beaglebone = "sdimage-bootpart.wks"

INHERIT += "blacklist"
PNBLACKLIST[build-appliance-image] = "tries to include whole downloads directory in /home/builder/poky :/"
PNBLACKLIST[smartrefrigerator] = "Needs porting to QT > 5.6"
PNBLACKLIST[qmlbrowser] = "Needs porting to QT > 5.6"
PNBLACKLIST[minehunt] = "Needs porting to QT > 5.6"
PNBLACKLIST[homeautomation] = "Needs porting to QT > 5.6"
PNBLACKLIST[samegame] = "Needs porting to QT > 5.6"
PNBLACKLIST[applicationlauncher] = "Needs porting to QT > 5.6"
PNBLACKLIST[spacetouch] = "Needs porting to libplanes 1.0"
PNBLACKLIST[qtviewplanes] = "Needs porting to libplanes 1.0"
PNBLACKLIST[egt-thermostat] = "Needs porting to egt 0.8.2+"

# mask out the old webkitgtk recipes from meta-webkit
BBMASK .= "recipes-browser/webkitgtk/webkitgtk"
