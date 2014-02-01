DESCRIPTION = "LCD test app and images"
HOMEPAGE = "https://github.com/cbrake/lcd-test"
SECTION = "utils"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.MIT;md5=544799d0b492f119fa04641d1b8868ed"
SRCREV = "bbc73b79dc5e6d26c079c6fe939cf0bc80c976f7"

SRC_URI = "git://github.com/cbrake/lcd-test.git;branch=master;protocol=git"

S = "${WORKDIR}/git/"

inherit qt4x11

do_install() {
	export INSTALL_ROOT=${D}
	make install
}

