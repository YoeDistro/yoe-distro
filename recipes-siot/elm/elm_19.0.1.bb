# Copyright (C) 2020 Cliff Brake <cbrake@bec-systems.com>
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "Elm Compiler"
SECTION = "devel"
LICENSE = "MIT"

LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz"
SRC_URI[md5sum] = "9584db6d744bc3179538ca6f7b3e0ff1"
SRC_URI[sha256sum] = "e44af52bb27f725a973478e589d990a6428e115fe1bb14f03833134d6c0f155c"

inherit bin_package

S = "${WORKDIR}"

do_install () {
    install -D -m755 ${S}/binary-for-linux-64-bit ${D}${bindir}/elm
}

INSANE_SKIP_${PN} += "already-stripped"
BBCLASSEXTEND = "native nativesdk"

COMPATIBLE_HOST_class-target = "null"

