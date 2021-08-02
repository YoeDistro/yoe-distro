FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# it pulls in buildessentials packagegroup into build dependency
# we can live with one less ptest package
# see below thread for details
# https://lists.openembedded.org/g/openembedded-core/topic/patch_1_2_v5_coreutils_add/72395668
RDEPENDS:${PN}-ptest:remove = "libmodule-build-perl"

RRECOMMENDS:${PN}-ptest += "libmodule-build-perl"
