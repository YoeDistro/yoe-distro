# Copyright (C) 2017 Khem Raj <raj.khem@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "Linux Backports"
HOMEPAGE = "https://backports.wiki.kernel.org"
SECTION = "kernel/modules"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"

SRCREV = "694b78f1533eb72c638c83754e0567630a93f456"

PV = "4.14-rc2-1"

SRC_URI = "http://www.kernel.org/pub/linux/kernel/projects/backports/stable/v4.14-rc2/backports-4.14-rc2-1.tar.gz \
	   file://backports_config \
"
SRC_URI[md5sum] = "4f00003de9a55b7277e096dafe9a6c20"
SRC_URI[sha256sum] = "7e3afa1f9f77e10af9c0f21da9c14e2bf2b0034f111b7a8b38d7be9ea6751c01"

S = "${WORKDIR}/backports-${PV}"

EXTRA_OEMAKE = "V=1 KLIB_BUILD=${STAGING_KERNEL_BUILDDIR} \
                KLIB=${base_libdir}/modules/${KERNEL_VERSION} \
		"

DEPENDS += "coreutils-native"

inherit module

MAKE_TARGETS = "modules"

FILES:${PN} += "${nonarch_base_libdir}/udev \
                ${sysconfdir}/udev \
		${nonarch_base_libdir} \
               "

EXCLUDE_FROM_WORLD = "1"

