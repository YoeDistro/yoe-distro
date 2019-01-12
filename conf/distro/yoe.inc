#
# Distro Settings
#
DISTRO_NAME = "Yoe Linux"
MAINTAINER = "Yoe Distro <https://github.com/YoeDistro>"
TARGET_VENDOR = "-yoe"
SDK_VENDOR = "-yoesdk"
# Distro version keep it up with Yocto release
DISTRO_VERSION = "2.6"
DISTRO_CODENAME = "master"
SDK_VERSION := "${DISTRO_VERSION}"

SDK_NAME = "${DISTRO}-${TCLIBC}-${SDKMACHINE}-${IMAGE_BASENAME}-${TUNE_PKGARCH}-${MACHINE}"
SDKPATH = "/opt/${DISTRO}/${SDK_VERSION}"

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

# The CONNECTIVITY_CHECK_URI's are used to test whether we can succesfully
# fetch from the network (and warn you if not). To disable the test set
# the variable to be empty.
# Git example url: git://git.yoctoproject.org/yocto-firewall-test;protocol=git;rev=master
CONNECTIVITY_CHECK_URIS ?= "https://www.example.com/"

PRSERV_HOST = "localhost:0"
TCLIBCAPPEND = ""

BUILDHISTORY_COMMIT ?= "1"

# the following is required because some BSP layers (fsl) don't set this, and then
# other BSP layers fail bitbake parsing (ti).
MACHINE_KERNEL_PR ??= "0"

# accound for some layers which have bbappends for layers we dont include
BB_DANGLINGAPPENDS_WARNONLY = "1"

# Poky goodness
# QA check settings - a little stricter than the OE-Core defaults
WARN_TO_ERROR_QA = "already-stripped compile-host-path install-host-path \
                    installed-vs-shipped ldflags pn-overrides rpaths staticdev \
                    unknown-configure-option useless-rpaths"
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

require conf/distro/include/no-static-libs.inc
require conf/distro/include/yocto-uninative.inc
require conf/distro/include/security_flags.inc

INHERIT += "uninative"

# Add /etc/build to every image
INHERIT += "image-buildinfo"

DISTRO_FEATURES_append = " largefile opengl ptest multiarch wayland pam "

#PREFERRED_PROVIDER_pkgconfig = "pkgconf"
#PREFERRED_PROVIDER_pkgconfig-native = "pkgconf-native"
#PREFERRED_PROVIDER_nativesdk-pkgconfig = "nativesdk-pkgconf"

PREFERRED_PROVIDER_virtual/libgl ??= "mesa"
PREFERRED_PROVIDER_virtual/psplash ??= "psplash"
PREFERRED_PROVIDER_psplash-support ??= "psplash"
PREFERRED_PROVIDER_jpeg ??= "libjpeg-turbo"
PREFERRED_PROVIDER_jpeg-native ??= "libjpeg-turbo-native"
PREFERRED_PROVIDER_grub-efi-native ??= "grub-efi-native"
PREFERRED_PROVIDER_u-boot-fw-utils ??= "u-boot-fw-utils"

# the following is required because some BSP layers (fsl) don't set this, and then
# other BSP layers fail bitbake parsing (ti).
MACHINE_KERNEL_PR = "0"
