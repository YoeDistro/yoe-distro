FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://overlayfs.cfg \
			file://nologo.cfg \
			file://wireguard.cfg \
			file://audit.cfg \
			file://kprobes.cfg"
