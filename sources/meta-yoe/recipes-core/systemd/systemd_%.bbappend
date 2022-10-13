FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

PACKAGECONFIG:append = " networkd resolved "

NETWORKING_SCRIPTS:qemuall = ""
NETWORKING_SCRIPTS ?= "file://wired.network \
                       file://wireless.network \
                       "
SRC_URI += "${NETWORKING_SCRIPTS}"

# Hack in meta-variscite-bsp layer for boot2qt which yoe does not need so remove this patch
# here
SRC_URI:remove = "file://0001-units-add-dependencies-to-avoid-conflict-between-con.patch"

do_install:append() {
	if [ "${@bb.utils.contains('IMAGE_CLASSES', 'qemuboot', 'True', 'False' ,d)}" != "True" ]; then
		install -d ${D}${sysconfdir}/systemd/network/
		install -m 0644 ${WORKDIR}/*.network ${D}${sysconfdir}/systemd/network/
	fi
}

FILES:${PN} += "{sysconfdir}/systemd/network/*"
