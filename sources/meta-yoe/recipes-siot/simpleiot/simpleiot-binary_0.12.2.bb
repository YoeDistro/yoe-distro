# Copyright (C) 2023 Khem Raj <raj.khem@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "Simple IOT Framework application"
HOMEPAGE = "http://simpleiot.org"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"
SECTION = "apps"

inherit systemd update-rc.d

ARCH:aarch64 = "arm64"
ARCH:arm = "armv7"
ARCH:x86 = "i386"
ARCH:x86-64 = "x86_64"
ARCH:riscv64 = "riscv64"

SRC_URI = "https://github.com/simpleiot/simpleiot/releases/download/v${PV}/simpleiot-v${PV}-linux-${ARCH}.tar.gz;name=simpleiot-${ARCH} \
           https://raw.githubusercontent.com/simpleiot/simpleiot/v${PV}/contrib/siot.service;name=systemd-service;downloadfilename=siot.service.v${PV} \
           https://raw.githubusercontent.com/simpleiot/simpleiot/v${PV}/contrib/siot.init;name=sysvinit-service;downloadfilename=siot.init.v${PV}"

SRC_URI[simpleiot-x86_64.sha256sum] = "1fea2d85c362308a83b998b659b0cfdbaec2f1da2026b2fbb09b525d8879cdae"
SRC_URI[simpleiot-i386.sha256sum] = "9b8a11649c2be5a1645bd7be58acc3c5ee19155385d26893c6359197b8c34176"
SRC_URI[simpleiot-arm64.sha256sum] = "bc1c81e12d5857467857e98a36a4f544322a700bc74c7aa1fd07fbdd473d08c9"
SRC_URI[simpleiot-armv7.sha256sum] = "dc31f9b0161bfd4a52e717f92826b9dea487a98090a12a216ce9b5319d0e849e"
SRC_URI[systemd-service.sha256sum] = "3167009256efc569190e4c581a2b3c5165f552f538d75b8e9497a6aa1ee21765"
SRC_URI[sysvinit-service.sha256sum] = "756c6ce43b9635b9196d50488e87fed94ce4b603463acd4f4c4c7ce14b32b29d"

S = "${WORKDIR}/simpleiot-v${PV}-linux-${ARCH}"

INITSCRIPT_NAME = "siot"
INITSCRIPT_PARAMS = "start 99 5 . stop 20 6 ."

do_configure() {
    :
}

do_compile() {
    :
}

do_install() {
    install -D -m 0755 ${S}/siot ${D}${bindir}/siot
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -D -m 0644 ${WORKDIR}/siot.service.v${PV} ${D}${systemd_unitdir}/system/siot.service
        sed -i "s:ExecStart=/usr/bin/siot:ExecStart=/bin/sh -c \"cd /data; /usr/bin/siot\":" \
            ${D}${systemd_unitdir}/system/siot.service
    else
        install -D -m 0755 ${WORKDIR}/siot.init.v${PV} ${D}${sysconfdir}/init.d/siot
    fi
}

SYSTEMD_SERVICE:${PN} = "siot.service"

INSANE_SKIP:${PN} += "already-stripped"
# we use sqlite and not all architectures seem to be supported see
# https://pkg.go.dev/modernc.org/sqlite#hdr-Supported_platforms_and_architectures
COMPATIBLE_HOST = "(x86_64.*|i.86.*|arm.*|aarch64.*|riscv64.*)-(linux)"

PROVIDES += "simpleiot"

