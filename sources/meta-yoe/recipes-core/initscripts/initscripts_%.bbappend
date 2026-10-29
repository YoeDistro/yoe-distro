FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Fill /etc/resolv.conf from the kernel's ip= autoconfiguration
SRC_URI += "file://resolvconf-ipconfig.sh"

do_install:append() {
	install -m 0755 ${S}/resolvconf-ipconfig.sh ${D}${sysconfdir}/init.d
	# after populate-volatile.sh (37) has created /var/run/resolv.conf
	update-rc.d -r ${D} resolvconf-ipconfig.sh start 38 S .
}
