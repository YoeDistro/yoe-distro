FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

PACKAGECONFIG_append = " networkd resolved "

NETWORKING_SCRIPTS_qemuall = ""
NETWORKING_SCRIPTS ?= "file://wired.network \
                       file://wireless.network \
                       "
SRC_URI += "${NETWORKING_SCRIPTS}"

do_install_append() {
	if [ "${@bb.utils.contains('IMAGE_CLASSES', 'qemuboot', 'True', 'False' ,d)}" != "True" ]; then
		install -d ${D}${sysconfdir}/systemd/network/
		install -m 0644 ${WORKDIR}/*.network ${D}${sysconfdir}/systemd/network/
	fi
}

FILES_${PN} += "{sysconfdir}/systemd/network/*"
