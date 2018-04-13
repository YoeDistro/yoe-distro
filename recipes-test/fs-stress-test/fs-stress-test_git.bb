DESCRIPTION = "File System stress test app"
HOMEPAGE = "https://github.com/cbrake/fs-stress-test"
SECTION = "utils"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.MIT;md5=544799d0b492f119fa04641d1b8868ed"
SRCREV = "354a1f6780c7c7490cda53489cd27527bee84eb6"

PV = "git${SRCPV}"
PR = "r1"

SRC_URI = "git://github.com/cbrake/fs-stress-test.git;branch=master;protocol=git"

S = "${WORKDIR}/git"

inherit autotools

