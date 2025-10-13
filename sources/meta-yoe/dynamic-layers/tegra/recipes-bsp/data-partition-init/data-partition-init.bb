# Copyright (C) 2025 Khem Raj <raj.khem@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)
SUMMARY = "First-boot formatter and mount units for persistent /data"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit systemd

SRC_URI = " \
    file://data-format.service \
    file://data.mount \
"

S = "${UNPACKDIR}"

# Install the units and create the mountpoint
do_install() {
	install -Dm 0644 ${UNPACKDIR}/data-format.service ${D}${systemd_system_unitdir}/data-format.service
	install -Dm 0644 ${UNPACKDIR}/data.mount ${D}${systemd_system_unitdir}/data.mount
}

FILES:${PN} += "${systemd_system_unitdir}/data-format.service \
                ${systemd_system_unitdir}/data.mount \
				"

SYSTEMD_PACKAGES = "${PN}"
SYSTEMD_SERVICE:${PN} = "data-format.service data.mount"

# Ensure we have the tools to format and probe filesystems
RDEPENDS:${PN} += "e2fsprogs-mke2fs util-linux-blkid"
