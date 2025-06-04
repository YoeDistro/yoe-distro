FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGECONFIG:remove = "gnutls"
PACKAGECONFIG:append = " openssl"

#SRC_URI:append = " file://0001-tls-tests-connection.c-Disable-unclean-close-by-serv.patch"
