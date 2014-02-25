DESCRIPTION = "LCD test app and images"
HOMEPAGE = "https://github.com/cbrake/lcd-test"
SECTION = "utils"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.MIT;md5=544799d0b492f119fa04641d1b8868ed"
SRCREV = "d63387ec78cf8497e37d6d21dce683ee9b9e358a"

SRC_URI = "git://github.com/cbrake/lcd-test.git;branch=master;protocol=git"

S = "${WORKDIR}/git/"

inherit qt4e

do_install() {
	export INSTALL_ROOT=${D}
	make install
}

