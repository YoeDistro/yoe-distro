DESCRIPTION = "File System stress test app"
HOMEPAGE = "https://github.com/cbrake/fs-stress-test"
SECTION = "utils"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.MIT;md5=544799d0b492f119fa04641d1b8868ed"
SRCREV = "6f50ca133b74197ae21c0e4e4619c90b14a5d1d3"

PV = "git${SRCPV}"
PR = "r1"

SRC_URI = "git://github.com/cbrake/fs-stress-test.git;branch=master;protocol=https"

S = "${WORKDIR}/git"

inherit autotools

