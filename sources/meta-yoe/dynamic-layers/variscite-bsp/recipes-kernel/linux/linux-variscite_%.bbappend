FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://overlayfs.cfg"
SRC_URI += "file://nologo.cfg"

SRC_URI += "file://0001-Enable-PCIE-for-imx8qm-var-som.patch"
