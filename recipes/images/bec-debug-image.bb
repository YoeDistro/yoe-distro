# this image includes the base utilities needed to exercise most
# embedded linux hardware

require recipes-images/angstrom/systemd-image.bb

#	e2fsprogs \
#	e2fsprogs-mke2fs \
#	e2fsprogs-fsck \
#	e2fsprogs-e2fsck \
#	e2fsprogs-tune2fs \
#	

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
	"

export IMAGE_BASENAME = "bec-debug-image"

