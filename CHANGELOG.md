# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

- Update linux-yocto/5.4 to v5.4.69
- Bump minimum required python version to 3.5
- Update lttng to 2.11.6
- Bump linux-fslc to v5.4.74
- Support tc358743 on Nitrogen8mm SOM
- At91bootstrap bumped to v3.10.0
- Add WILC apps to microchip-headless-image
- Add support for SRC_URI containing spaces in url
- Update timezone data to 2020b
- Add sama7g5ek-emmc machine
- Remove compiler arguments from CLANG_TIDY_EXE
- Add fetcher support for master to main branchname transition in git
- Fix qt5-creator build and upgrade to 4.13.1
- Update linux-raspberrrypi to 5.4.72
- Update linux-ti-staging to 5.4.72
- Build ashmem and binder drivers for raspberrypi
- Update gstreamer1.0 to 1.16.3
- Mitigate the Straight-line Speculation attack in gcc
- Fix parsing of slim encoded tzdata in glib-2.0

## [3.1.3] - 2020-10-08

- Remove freedesktop.org urls
- Add sama7g5ek-sd support
- Update linux-fslc-imx and linux-fslc to v5.4.70
- Update iwd to 1.9.x
- Pin glibc version for riscv-32
- Update linux-ti-staging to 5.4.66
- build-appliance-image uses dunfell now
- Add kernel-cache source for rpi kernel
- Update linux-intel to v5.4.68 and linux-intel-rt to v5.4.66
- Fix u-boot-boundary bootscripts
- optee-os fixed to build with gcc-10
- bump component revisions for sama7g5ek-sd machine
- u-boot-socfpga updated to v2020.04 and add v2020.07
- Fix wic option --extra-space and add --offset
- Improve wic error messages on invalid offset
- Update altera kernel to 5.4.54, uboot to 2020.04
- Update linux-fscl to 5.4.65
- Netsnmp,json-c and LUA CVE fixes
- linux-yocto upgrade to 5.4.61
- qcom kernel updated to 5.7.19
- Fixed cve-check tool for multiconfig, add progress bar
- Security fixes for libxml2,cmake,gnutls,libx11,qemu
- Use uninative 2.9 supports glibc 2.32 on host
 
## [3.1.2] - 2020-09-05

- Dropped meta-webkit from default distro layers
- Go compiler upgraded to 1.14.7
- TI and FSL Kernel updated to 5.4.58
- Fixed Altera boot issues with wic image
- CVE fixes for glibc 2.31 and gcc 9.3
- linux-variscite updated to 4.14
- Vivante Driver updated to 6.4.0.p2.0
- linux-intel updated to 5.4.57
- RPI machines switched to use 5.4 kernel
- Linux yocto updated to v5.4.61
- RISCV32 uses upstream master for glibc
- linux-fslc updated to v5.4.61
- Update rust to 1.46
- Various build fixes for arm trusted-firmware-a
- Update bind to 9.11.22, libubootenv to v0.3
- Move meta-yoe to main yoedistro repo
