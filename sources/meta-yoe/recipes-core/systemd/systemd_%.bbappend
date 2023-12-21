FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

PACKAGECONFIG:append = " networkd resolved coredump"

NETWORKING_SCRIPTS ?= "file://wired.network \
                       file://wireless.network \
                       "
SRC_URI += "${NETWORKING_SCRIPTS}"

# Hack in meta-variscite-bsp layer for boot2qt which yoe does not need so remove this patch
# here
SRC_URI:remove = "file://0001-units-add-dependencies-to-avoid-conflict-between-con.patch"

do_install:append() {
  install -d ${D}${sysconfdir}/systemd/network/
	install -m 0644 ${WORKDIR}/*.network ${D}${sysconfdir}/systemd/network/
	if ${@bb.utils.contains('PACKAGECONFIG', 'timesyncd', 'true', 'false', d)}; then
		install -d ${D}${sysconfdir}/systemd/system/sysinit.target.wants/
		ln -sf ${systemd_system_unitdir}/systemd-time-wait-sync.service ${D}${sysconfdir}/systemd/system/sysinit.target.wants/systemd-time-wait-sync.service
	fi
}

FILES:${PN} += "{sysconfdir}/systemd/network/*"
