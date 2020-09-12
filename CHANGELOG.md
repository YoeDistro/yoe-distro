# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

- Update go compiler to 1.15
- Improve error and cleanup handing in cooker
- Update linux-fslc to v5.4.64
- Various recipe version upgrades
- Remove help2man from early build depenencies
- Update linux-altera-lts 5.4.54 and u-boot-socfpga to 2020.04
- Various recipe version upgrades in meta-openembedded
- Update linux-intel to 5.4.59
- ARMv8 tune cleanups
- Add RISCV32 support for musl

## [3.2.0-alpha] - 2020-09-05

- Dropped meta-webkit from default distro layers
- Update glibc to 2.32 and binutils 2.35 major versions
- Systemd upgaded to 246
- Musl upgraded to 1.2.1
- Go upgraded to 1.14.7
- Several packages fixed to work with -fno-common ( gcc10 defaults )
- RPI kernel defaults to 5.4 instead of 4.19
- Yocto 5.4 kernel upgraded to 5.4.57
- imx kernel update to 5.4.56
- Clang update to 11.0.0-rc2
- Clang SDKs are now relocatable
- Switch linux to 5.8 for kernel UAPI
- GCC updated to 10.2.0
- SWitch gcc to use -fno-common ( upstream default )
- Use upstream master branch for RISCV-32
- Fix RPI X11 builds with Userland graphics
- Update Vivante driver to 6.4.0.p2.0 based release
- Add 5.4 android common kernel for meta-arm
- Add tune files for cortexa73-cortexa35/ARMv8-2a
- Fix meta-openembedded test images e.g. meta-oe-ptest-image
- Use glibc master for RISCV32
- Move kea/dhcpcd from meta-openembedded to opemebedded-core
- Fix QT5 recipes with clang-11
- Move meta-yoe into yoedistro repo
