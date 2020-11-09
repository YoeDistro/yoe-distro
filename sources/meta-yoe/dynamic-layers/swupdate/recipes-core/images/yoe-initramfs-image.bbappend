FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

PACKAGE_INSTALL_append = "\
  libconfig \
  swupdate \
  swupdate-www \
"
