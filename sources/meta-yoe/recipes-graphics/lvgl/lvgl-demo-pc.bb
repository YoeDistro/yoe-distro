# Copyright (C) 2022 Cliff Brake <cbrake@bec-systems.com>
# Released under the MIT license (see COPYING.MIT for the terms)

SUMMARY = "LVGL Demo Application (PC)"
HOMEPAGE = "https://github.com/lvgl/lv_port_pc_eclipse"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
SECTION = ""
DEPENDS = "libsdl2"

inherit cmake

SRC_URI = "gitsm://github.com/lvgl/lv_port_pc_eclipse.git;branch=master;protocol=https"

SRCREV = "96c457872f18e395b7c419512642195ab5e6bbc0"

S = "${WORKDIR}/git"
