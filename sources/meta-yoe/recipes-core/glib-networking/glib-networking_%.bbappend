FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG_remove = "gnutls"
PACKAGECONFIG_append = " openssl"
