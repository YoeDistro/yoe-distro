# Copyright (C) 2020 Cliff Brake <cbrake@bec-systems.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Simple IOT Framework application"
HOMEPAGE = "http://simpleiot.org"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
SECTION = "apps"

DEPENDS = "go-native elm-native"

inherit update-rc.d goarch

SRCREV = "9aa0cf5116eb5f770f7e6a2a2f2e624398a72234"
PV = "1.0+git${SRCPV}"

SRC_URI = "git://github.com/simpleiot/simpleiot \
           file://siot \
           "
S = "${WORKDIR}/git"

GOPATH = "${TMPDIR}/work-shared/go"

INITSCRIPT_NAME = "siot"
INITSCRIPT_PARAMS = "start 99 5 . stop 20 6 ."

do_configure() {
    export GOPATH=${GOPATH}
    export GOFLAGS="-modcacherw"
    go install github.com/benbjohnson/genesis/...
}

do_compile() {
    export GOPATH=${GOPATH}
    export GOARCH=${TARGET_GOARCH}
    export PATH=${GOPATH}/bin:$PATH
    export GOFLAGS="-modcacherw"
    source ./envsetup.sh
    # FIXME: get elm cache in ~/.elm moved to work-shared
    rm -rf frontend/elm-stuff
    siot_setup
    siot_build
}

do_install() {
    install -D -m 0755 ${S}/siot ${D}${bindir}/siot
    install -D -m 0755 ${WORKDIR}/siot ${D}${sysconfdir}/init.d/siot
}

INSANE_SKIP_${PN} += "ldflags"
