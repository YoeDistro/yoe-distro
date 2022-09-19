FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Enable zstd compression backend
PACKAGECONFIG:append = " zstd"
