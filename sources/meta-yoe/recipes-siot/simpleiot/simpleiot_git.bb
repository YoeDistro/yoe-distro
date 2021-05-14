# Copyright (C) 2020 Cliff Brake <cbrake@bec-systems.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Simple IOT Framework application"
HOMEPAGE = "http://simpleiot.org"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
SECTION = "apps"

DEPENDS = "go-native elm-binary-native nodejs-native"

inherit systemd update-rc.d goarch

SRCREV = "72f6d6059ea998af91a1333cd5080969108e1095"
PV = "0.0.14+git${SRCPV}"

BRANCH ?= "master"

SRC_URI = "git://github.com/simpleiot/simpleiot;branch=${BRANCH} \
           "
S = "${WORKDIR}/git"

GOPATH = "${TMPDIR}/work-shared/go"

CGO_ENABLED_x86-64 = "0"
export CGO_ENABLED

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
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -D -m 0644 ${S}/contrib/siot.service ${D}${systemd_unitdir}/system/siot.service
    else
        install -D -m 0755 ${S}/contrib/siot.init ${D}${sysconfdir}/init.d/siot
    fi
}

SYSTEMD_SERVICE_${PN} = "siot.service"

INSANE_SKIP_${PN} += "ldflags already-stripped"

