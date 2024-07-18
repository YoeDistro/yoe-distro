FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

PACKAGECONFIG:append = " networkd resolved coredump"

# Add wireless.network here if the system has wifi and
# it is managed via wpa-supplicant + systemd-networkd
# if using networkmanager wireless.network file is not needed
NETWORKING_SCRIPTS ?= "file://wired.network \
                       "
SRC_URI += "${NETWORKING_SCRIPTS}"

# Hack in meta-variscite-bsp layer for boot2qt which yoe does not need so remove this patch
# here
SRC_URI:remove = "file://0001-units-add-dependencies-to-avoid-conflict-between-con.patch"
# remove another meta-variscite-bsp patch which is trying to get networkmanager going with systemd
# however it was never used in yoe
SRC_URI:remove = "file://0002-units-disable-systemd-networkd-wait-online-if-Networ.patch"

do_install:append() {
  install -d ${D}${sysconfdir}/systemd/network/
	install -m 0644 ${UNPACKDIR}/*.network ${D}${sysconfdir}/systemd/network/
	if ${@bb.utils.contains('PACKAGECONFIG', 'timesyncd', 'true', 'false', d)}; then
		install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants/
		ln -sf ${systemd_system_unitdir}/systemd-time-wait-sync.service ${D}${sysconfdir}/systemd/system/sysinit.target.wants/systemd-time-wait-sync.service
	fi
}

FILES:${PN} += "{sysconfdir}/systemd/network/*"
