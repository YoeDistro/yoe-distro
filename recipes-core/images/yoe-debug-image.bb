# this image includes the base utilities needed to exercise most
# embedded linux hardware

# note, the following must be set to build netperf:
# LICENSE_FLAGS_WHITELIST = "non-commercial"
# see conf/locallocal.conf.sample in BEC build template

#	e2fsprogs \
#	e2fsprogs-mke2fs \
#	e2fsprogs-fsck \
#	e2fsprogs-e2fsck \
#	e2fsprogs-tune2fs \
#
require recipes-extended/images/core-image-full-cmdline.bb

IMAGE_INSTALL += "\
	rsync \
	devmem2 \
	evtest \
	netperf \
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
	dosfstools \
	usbutils \
	i2c-tools \
	minicom \
	screen \
	wireless-tools \
	cpufrequtils \
	nano \
	cpuburn-neon \
	sox \
	strace \
	ethtool \
	python \
	python-pyserial \
	"

export IMAGE_BASENAME = "yoe-debug-image"
