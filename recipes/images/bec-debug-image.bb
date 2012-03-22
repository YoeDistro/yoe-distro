# this image includes the base utilities needed to exercise most
# embedded linux hardware

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/LICENSE;md5=3f40d7994397109285ec7b81fdeb3b58"

IMAGE_PREPROCESS_COMMAND = "rootfs_update_timestamp"

DISTRO_UPDATE_ALTERNATIVES ??= ""
ROOTFS_PKGMANAGE_PKGS ?= '${@base_conditional("ONLINE_PACKAGE_MANAGEMENT", "none", "", "${ROOTFS_PKGMANAGE} ${DISTRO_UPDATE_ALTERNATIVES}", d)}'

CONMANPKGS ?= "connman connman-plugin-loopback connman-plugin-ethernet connman-plugin-wifi connman-systemd"
CONMANPKGS_libc-uclibc = ""

IMAGE_INSTALL += "\
	angstrom-task-boot \
	task-basic \
	${CONMANPKGS} \
	${ROOTFS_PKGMANAGE_PKGS} \
	kernel-modules \
	rsync \
	devmem2 \
	evtest \
	netperf \
	madplay \
	gdbserver \
	gdb \
	mtd-utils \
	tslib \
	tslib-calibrate \
	tslib-tests \
	alsa-utils \
	alsa-utils-alsamixer \
	alsa-utils-aconnect \
	alsa-utils-alsaconf \
	alsa-utils-alsactl \
	alsa-utils-alsamixer \
	alsa-utils-amixer \
	alsa-utils-aplay \
	alsa-utils-aseqdump \
	alsa-utils-aseqnet \
	alsa-utils-iecset \
	alsa-utils-speakertest \
	e2fsprogs \
	e2fsprogs-mke2fs \
	e2fsprogs-fsck \
	e2fsprogs-e2fsck \
	e2fsprogs-tune2fs \
	dosfstools \
	usbutils \
	i2c-tools \
	minicom \
	wireless-tools \
	cpufrequtils \
	angstrom-uboot-scripts \
	nano \
	cpuburn-neon \
	sox \
	task-base-bluetooth \
	task-base-wifi \
	strace \
	screen \
	"

IMAGE_DEV_MANAGER   = "udev"
IMAGE_INIT_MANAGER  = "systemd"
IMAGE_INITSCRIPTS   = " "
IMAGE_LOGIN_MANAGER = "tinylogin shadow"

export IMAGE_BASENAME = "bec-debug-image"

inherit image

