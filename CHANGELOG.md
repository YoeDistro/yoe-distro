# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## Unreleased

- Updater support added for beaglebone and raspberrypi4-64
- Add yoe-install-image for factory install
- Use kernel+initramfs always for non-qemu machines
- Fix LTO builds with clang
- Fix Perf on IMX platforms
- Update intel-microcode to 20201112
- mchp-wireless-firmware: bump to 15.4.1
- Clang updated to 11.0.1
- Fix Numpy runtime issue when build with clang
- Update ODROID-N2 to use u-boot 2020.10 
- Many packages fixed to build for RISCV32
- Update linux-yocto to v5.4.75 v5.8.18
- Enable Qemu Usermode on RISCV32
- Update linux-altera to 5.4.64
- Update linux-fslc to v5.4.78
- Disable LTO for qtbase

## [3.3.0-alpha] - 2020-11-11

- Add new UBOOT_CONFIG to support ATF on QSPI boot for altera SOCs
- Fix gstreamer1.0 builds on iMX SOCs
- Upgrade hardkernel uboot to lates 2015 release and kernel to 4.9.236
- Use DTB Overlay on Odroid-C4
- Fix QT builds with clang and on 32bit arches with 64bit time_t e.g. riscv32
- Fix Qtwebkit build with python 3.9
- Update linux-ti-staging to 5.4.74
- Update linux-fslc to v5.4.75
- Install vpu fw for mx8qm/mx8qxp based machines
- Fix gstreamer1.0-omx build with 1.18 gstreamer upgrade
- Add harknott (3.3) compatiblity to riscv layer
- Add swupdate support for odroid-c4
- Add Updater support for odroid-c4

## [3.2.0] - 2020-11-04

- Fix yoe-debug-image for riscv32
- Add sama7g5ek-emmc machine
- Fix using clang-tidy
- Misc Python updates
- Fix userland package

## [3.2.0-rc.1] - 2020-10-18

- Migrate documentation to use sphinx
- Handle backslash support in file:// URIs
- Switch arm-bsp to 5.4 based kernel
- Bump components for sama7g5ek-sd
- Create symlinks with cross compile tuples for clang
- Update FSL EULA  to LA_OPT_NXP_Software_License v11 February 2020
- Fix asound.conf for cubox-i
- Update linux-ti-staging to 5.4.69
- Update linux-fslc-imx/linux-fslc to v5.4.71
- Update linux-altera to 5.7
- systemd upgraded v246.2 -> v246.6
- Fix perf on arm/musl
- mesa updated 20.1.6 -> 20.1.8
- Fix ptest-runner to detatch tty correctly
- Use modcacherw always for go modules
- Fix clang/musl SDK
- Improve cve-check to detect applied CVEs
- Add ESDK_MANIFEST_EXCLUDES for eSDK to filter conf/ dir
- Fix zephyr support for arm BSPs
- Update clang to 11.0.0-RC6
- Update intel-mediasdk to 20.3.0
- Update linux-intel to v5.4.68
- Start using yocto kernel tooling for linux-raspberrypi
- Update RPI firmware to  20190114-1+rpt8
- Update linux-raspberrypi to 5.4.69
- Enable LTP builds on riscv32/musl
- Support ARMv8.2a tunes
- Add faster 34Kf-64tlb Qemu machines
- Update linux-yocto v5.8.13/v5.4.69
- Add ttarget RISCV64/RISCV32 builds for clang

## [3.2.0-beta] - 2020-09-23

- Update go compiler to 1.15.2
- Improve error and cleanup handing in cooker
- Update linux-fslc to v5.4.66
- Various recipe version upgrades
- Remove help2man from early build depenencies
- Update linux-altera-lts 5.4.54 and u-boot-socfpga to 2020.04
- Various recipe version upgrades in meta-openembedded
- Update linux-intel to 5.4.59
- ARMv8 tune cleanups
- Add RISCV32 support for musl
- Documentation converted to sphinx
- python3-pyqt5 updated to 5.15.1
- QTWebengine bison 3.7 fix, and sanbox freeze fixed
- Fix mutter launch with vc4graphics on raspberrypi
- linux-yocto updated to v5.8.9, v5.4.65
- Add support for sama7g5ek-sd in meta-atmel
- Clang updated to 11.0.0 RC3
- Various Recipe upgrades

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
