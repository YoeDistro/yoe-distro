# this image includes the base utilities needed to exercise most
# embedded linux hardware

# note, the following must be set to build netperf/sox:
# LICENSE_FLAGS_WHITELIST = "non-commercial"
# see conf/locallocal.conf.sample in Yoe build template

#	e2fsprogs \
#	e2fsprogs-mke2fs \
#	e2fsprogs-fsck \
#	e2fsprogs-e2fsck \
#	e2fsprogs-tune2fs \
#
require yoe-simple-image.bb

IMAGE_FEATURES += "tools-debug tools-profile"

IMAGE_INSTALL += "\
	rsync \
	devmem2 \
	evtest \
	netperf \
	mtd-utils \
	tslib \
	tslib-calibrate \
	tslib-tests \
	alsa-utils \
	alsa-utils-alsamixer \
	alsa-utils-aconnect \
	alsa-utils-alsactl \
	alsa-utils-alsamixer \
	alsa-utils-amixer \
	alsa-utils-aplay \
	alsa-utils-aseqdump \
	alsa-utils-aseqnet \
	alsa-utils-iecset \
	alsa-utils-scripts \
	alsa-utils-speakertest \
	dosfstools \
	usbutils \
	i2c-tools \
  iw \
	minicom \
	screen \
	cpufrequtils \
	nano \
	sox \
	ethtool \
	python3 \
	python3-pyserial \
	"

IMAGE_INSTALL:append:armv7a = " cpuburn-arm "
IMAGE_INSTALL:append:armv7ve = " cpuburn-arm "
IMAGE_INSTALL:append:aarch64 = " cpuburn-arm "

export IMAGE_BASENAME = "yoe-debug-image"

QB_MEM = "-m 2048"
