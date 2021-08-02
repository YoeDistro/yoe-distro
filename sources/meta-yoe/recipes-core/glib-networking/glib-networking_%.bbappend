FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG:remove = "gnutls"
PACKAGECONFIG:append = " openssl"
