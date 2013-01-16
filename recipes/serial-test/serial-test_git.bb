DESCRIPTION = "Serial test application"
HOMEPAGE = "https://github.com/cbrake/linux-serial-test"
SECTION = "utils"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.MIT;md5=544799d0b492f119fa04641d1b8868ed"
SRCREV = "4d5c8a4b40bdbee41e30244727b8813bc669d002"

PV = "git${SRCPV}"
PR = "r2"

SRC_URI = "git://github.com/cbrake/linux-serial-test.git;branch=master;protocol=git"

S = "${WORKDIR}/git/"

inherit cmake

