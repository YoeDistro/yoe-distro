# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

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
