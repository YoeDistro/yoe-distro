DESCRIPTION = "Script run as a part of swupdate install for tegra"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
    file://tegra-swupdate-script.lua.in \
"

S = "${UNPACKDIR}"
B = "${WORKDIR}/build"

inherit tegra_swupdate deploy

do_compile() {
    sed -e's,@TEGRA_SWUPDATE_BOOTLOADER_INSTALL_ONLY_IF_DIFFERENT@,${TEGRA_SWUPDATE_BOOTLOADER_INSTALL_ONLY_IF_DIFFERENT},g' \
        -e's,@TEGRA_SWUPDATE_CAPSULE_INSTALL_PATH@,${TEGRA_SWUPDATE_CAPSULE_INSTALL_PATH},g'\
        ${S}/tegra-swupdate-script.lua.in > ${B}/tegra-swupdate-script.lua
}

do_deploy() {
    cp ${B}/tegra-swupdate-script.lua ${DEPLOYDIR}/
}

addtask deploy after do_install
