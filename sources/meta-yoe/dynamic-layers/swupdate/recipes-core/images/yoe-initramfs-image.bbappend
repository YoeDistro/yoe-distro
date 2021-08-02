FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

PACKAGE_INSTALL:append = "\
  libconfig \
  swupdate \
"
