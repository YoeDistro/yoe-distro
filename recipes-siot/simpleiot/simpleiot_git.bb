# Copyright (C) 2020 Cliff Brake <cbrake@bec-systems.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Simple IOT Framework application"
HOMEPAGE = "http://simpleiot.org"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
SECTION = "apps"

DEPENDS = "go-native elm-binary-native nodejs-native"

inherit update-rc.d goarch

SRCREV = "98fdb1f2c0bc9c303692ad1c092ba48146e77b08"
PV = "0.0.5+git${SRCPV}"

BRANCH ?= "master"

SRC_URI = "git://github.com/simpleiot/simpleiot;branch=${BRANCH} \
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
    . ${S}/envsetup.sh
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
