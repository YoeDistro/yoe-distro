DESCRIPTION = "LCD test app and images"
HOMEPAGE = "https://github.com/cbrake/lcd-test"
SECTION = "utils"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE.MIT;md5=544799d0b492f119fa04641d1b8868ed"
SRCREV = "ff22957e1b836863e4fbd57437a2a518e87d0ef5"

DEPENDS = "gtk+"

SRC_URI = "git://github.com/cbrake/lcd-test.git;branch=master;protocol=https"

inherit cmake pkgconfig features_check

ANY_OF_DISTRO_FEATURES = "${GTK2DISTROFEATURES}"

