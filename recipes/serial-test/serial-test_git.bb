DESCRIPTION = "Serial test application"
HOMEPAGE = "https://github.com/cbrake/linux-serial-test"
SECTION = "utils"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.MIT;md5=544799d0b492f119fa04641d1b8868ed"
SRCREV = "e777a65ea333955315e22c829aee7c16a6882cbb"

PV = "git${SRCPV}"
PR = "r3"

SRC_URI = "git://github.com/cbrake/linux-serial-test.git;branch=master;protocol=git"

S = "${WORKDIR}/git/"

inherit cmake

