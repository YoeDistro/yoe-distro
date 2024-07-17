FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://overlayfs.cfg \
			file://nologo.cfg \
			file://wireguard.cfg \
			file://kprobes.cfg"
