# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2025.12] - 2025-12-xx

### Changed

- Update mpd to 0.24.6
- Update dbus-broker to 37 and add ptest support
- Upgrade linux-raspberrypi-6.12 to 6.12.58
- Add kas project for orangepi-rv2 in meta-riscv
- Upgrade gstreamer 1.26.5 -> 1.26.7
- Upgrade clang to 21.1.7
- Switch recipes which need PCRE to use libpcre2 as first choice
- Add ptest support for gupnp-av and gssdp
- Add support for swupdate 2025.12 release
- Add support for llvm-libgcc
- Upgrade gtk4 to 4.20.2
- Add ptest support for gupnp-igd, libcheck
- Fix recipes to build with upcoming glibc 2.43+
- Upgrade PHP to 8.5.0
- Disable LTO with clang for some recipes e.g. bluez, zlib, systemd-boot
- Add -ffat-lto-objects to clang LTO settings
- Add HOMEPAGE entry in several recipes
- Normalizing <cmath> usage in cuda-cccl to fix macros
- Upgrade systemd to 258.1
- Add clock group in base filesystem
- Upgrade sqlite to 3.51.1
- Upgrade go compiler to 1.25.5
- Upgrade linux-yocto/6.12 to v6.12.60 and linux-yocto/6.17 to 6.17.10
- Upgrade valgrind to 3.26.0
- Fix packagegroups contents to exclude packages not building for riscv32
- In ripgrep limit libstd-rs dependency to apply for target alone
- Enable fortran support at distro scope for yoe

### Added

- New recipes - python3-fastapi[-cli], python3-annotated-doc, python3-soundcard
  python3-mpv, python3-svglib, python3-cssselect2, python3-tinycss2
  python3-reportlab, colortail, holohub-apps, ngc-cli, ucxx, matx
  concurrentqueue, claraviz, ripgrep, fd-find, python3-sphinxcontrib-svg2pdfconverter

### Removed

- Removed recipes - yasm, lowpan-tools, libconfig-tegra
- Remove dleyna support and recipes from meta-openembedded

## [2025.11] - 2025-11-30

### Changed

- Update linux-yocto/6.12: to 6.12.55
- Introduce linux-yocto/6.17 and update to v6.17.6
- Apply --print-multiarch omission in python to non-native builds with clang
- Update gnome-software to 49.1
- Fix uuu build with clang-21 and cmake-4
- Fix linux-firmware and perf build with linux-variscite 6.1
- Add UPSTREAM_CHECK_PYPI_PACKAGE for several packages in meta-openembedded
- Switch variscite imx8 projects to use scarthgap release with 6.6.52 kernel
- Upgrade curl to 8.17.0
- Upgrade clang/llvm to 21.1.5 release
- Upgrade openSSH to 10.2p1
- Use SRC_URI from gnomebase for several recipes in OE-core
- Upgrade go compiler to 1.25.4
- Fix Nezha/RISCV machine build and boot
- Fix yoe updater for VisionFive2 project
- Remove php-phar from PHP to support reproducible build
- Upgrade VisionFive2 to use JH7110_VF2_6.12_v6.0.0 SDK and 6.12 kernel
- Fix weston crash on RPI machines
- Upgrade QT6 to 6.10.2
- Fix building visionfive2 SDK firmware fetching location
- Fix -fcanon-prefix-map handling
- Use native gawk to fix glibc reproducibility

### Added

- Added recipes - python3-checksec-py, python3-pylddwrap, python3-icontract
  fex, gpp, gtk-layer-shell,

### Removed

- Removed tcp-wrappers recipes and support in other packages

## [2025.10] - 2025-10-31

### Changed

- Use clang for native pieces for qtpdf as well
- Upgrade mariaDB to 11.4.8
- Upgrade reference u-boot 2025.07 -> 2025.10
- Upgrade OpenSSL to 3.5.4
- Separate clang and llvm into separate recipes
- Upgrade Clang/LLVM to 21.1.4 release
- Update musl to tip of trunk
- Require mimimum gcc version on build host to 10.1
- Upgrade abseil-cpp to 20250814.1 release and fix its dependents
- Add dmem support in OpenOCD for am64xx and j784s4 platforms
- Fix tegra-storage-layout to work with UNPACKDIR change
- Upgrade go compiler to 1.25.3
- Add persisten /data partition to AGX platforms, reduce rootfs size to 8GB
- Update LVGL recipes to 9.4.0
- Update rtorrent to 0.16.1
- Fix failing ptests in meta-oe, meta-perl layers
- Update PHP to 8.4.14
- Upgrade NodeJS to 22.21.0
- Upgrade linux-yocto/6.16 to 6.16.11 and linux-yocto/6.12 to 6.12.52
- Use llvm instead of rust-llvm in rust recipe
- Upgrade openssh to 10.0p1 -> 10.1p1
- Upgrade OPKG 0.7.0 -> 0.8.0
- Fix cross-canadian packages to work with clang in SDK environment

### Added

- Added recipes - touchpademulator, gni, python3-pcpp, python3-questionary
  python3-pyfiglet, python3-pybase64, python3-orjson, python3-mmh3
  libpisp
- Add new machine for Raspberry Pi 2B V1.2 (64-bit)
- Add support for OrangePi RV2 with mainline Linux
- Add zsh-completion-pkgs image feature

### Removed

- Removed recipes - rust-llvm

## [2025.09] - 2025-09-30

### Changed

- Reduce use of --undefined-version with lld, fix recipes
- Upgrade to Clang 21.1.0 major release
- Fix and upgrade recipes to build with clang-21
- Upgrade bpftrace to 0.24.0
- Upgrade boost to 1.89.0 and fix recipes for API changes
- Check recipes needing opengl distro feature
- Upgrade klibc to 2.0.14
- Upgrade nodejs to 22.19.0
- Fix beaglev-ahead support and upgrade kernel to 6.15
- Update NVCC GCC to 13.2
- Add support for OVERLAYS for tegra platforms
- Bump default kernel reference for QEMU machines to 6.16
- Upgrade mesa to 25.2.2
- Upgrade linux-yocto/6.16 to 6.16.9 and linux-yocto/6.12 to 6.12.49
- Upgrade ruby to 3.4.5
- Upgrade rust compiler to 1.89.0
- Address all failures in core-image-ptest-all for qemux86-64/musl
- Upgrade apt to 3.0.3
- Upgrade QT6 to use 6.10 release
- Upgrade ffmpeg to 8.0 and fix recipes to build with ffmpeg 8.0 APIs
- Fix beaglev-ahead kernel builds
- Enable GPU backends for the opencl DISTRO_FEATURE
- Upgrade clang to 21.1.1 release
- Upgrade binutils on to latest on 2.45 release branch
- Remove fcntl-lock from util-linux
- Provide virtuals for vulkan and opencl drivers in mesa-pvr-riscv
- Update curl to 8.16.0
- Update mesa to 25.2.3
- Use OE-core + bitbake instead of poky repo for core layer

### Added

- New recipes - python3-pre-commit, python3-nodeenv, python3-identify
  python3-ukkonen, python3-cfgv, libnvjpeg, tinycompress, libtatsu
- Add opencl new distro feature
- Add erofs filesystem types support to Runqemu

### Removed

- Delete COMPILER_RT and LIBCPLUSPLUS variables and its use

## [2025.08] - 2025-08-27

### Changed

- Upgrade binutils to 2.45 release
- Upgrade bash to 5.3
- Cleanup setuptools3 class and enable parallelism in build step
- Upgrade Rust from 1.87.0 -> 1.88.0
- Fix recipes to build with glibc 2.42
- Update NodeJS to 22.18.0
- Update pydantic core to 2.37.2 and fix build on RISCV32
- Use correct Python build backend class in several python module recipes
- Split lld into a separate recipe out of clang
- Enable ccache for all recipes if it is in HOSTTOOLS
- Add +nocrypto to -mcpu when crypto not in features
- Upgrade glibc to 2.42 release
- Default to zstd compressed image output
- Update musl to tip of trunk
- Tweak nftables, networkmanager, wireguard, yoe-simple-image to shed bash, readline
  libgmp, from image
- Update linux-raspberrypi to 6.12.41
- Update L4T from R36.4.3 -> R36.4.4, JetPack 6.2.1
- Update OpenSSL to 3.5.2
- Upgrade golang compiler to 1.25.0
- Fix GCS annotations in compiler-rt on aarch64
- Upgrade systemd to 257.8
- Upgrade vulkan recipes to 1.4.321
- Fix several recipes to work with x86-64-v3 tune
- Upgrade gstreamer to 1.26.5
- Handle USE_NLS in systemd and related dependencies
- Switch qemux86-64 machine defaults to use x86-64-v3 tune
- Update linux-yocto/6.12 to v6.12.41
- Switch linux UAPI headers to v6.16
- Devtool fixed for upgrading recipes which use git submodules
- Upgrade cmake to 4.1.0
- Upgrade GCC to 15.2.0 release
- Musl ptests fixes for elfutils, strace
- Upgrade LTTng and related recipes to 2.14.0
- Use nocrypto default tunes for raspberrypi3-64,raspberrypi4-64
- Fix several musl ptests in core-image-ptest-all
- Introduce 6.16 reference kernels

### Added

- Add xz to HOSTTOOLS
- Add PEP517 build class for PDM
- Add yoe env function to setup direct eSDK
- Add runqemu support for running compressed .zst rootfs images
- New recipes: clight, clightd, libmodule
- Add nocrypto tune variant for cortex-a53 and cortex-a72 CPUs

### Removed

- Remove runtime-llvm override
- Drop var-undefined QA check from package class
- Remove distro_alias file
- remove nghttp2-proxy from remove nghttp2
- Remove babeltrace in favor of babeltrace2

## [2025.07] - 2025-07-31

### Changed

- Adjust for S changing defaults to be in UNPACKDIR
- Upgrade protobuf to 6.31.1
- Upgrade clang to 20.1.7
- Upgrade rust compiler from 1.86.0 to 1.87.0
- Enable glvnd in mesa if it is enabled in DISTRO_FEATURES
- Update uninative to 4.8 for GCC 15.1
- Upgrade go compiler to 1.24.4
- Fix several recipes to build with Cmake 4+
- Update Linux UAPI libc headers to v6.15
- Enable TUNE_FEATURES based KERNEL_FEATURES for RISCV
- Update linux-yocto/6.12 to v6.12.38
- Handle workspaces for multiconfig in devtool
- Add support for xz archives for XFCE components tarballs in SRC_URI
- Upgrade go compiler from 1.24.4 -> 1.24.5
- Fix building with clang-native when using compiler-rt
- Upgrade openSSL from 3.5.0 -> 3.5.1
- Fix compiler-rt nativesdk builds when using clang and llvm runtime
- Split libclc into a independent recipe out of clang
- Upgrade cmake to 4.0.3
- Upgrade clang to 20.1.8 release
- Upgrade QT6 to latest 6.9 release

### Added

- Added recipes - gpicview, pstack, opensbi-revyos, python3-colorama
  python3-sphinx-argparse, python3-sphinx-copybutton, python3-pytest-sugar
  systemd-repart-native, nilfs-utils, python3-rich-argparse, python3-genson
  cpp-argparse, python3-jsonschema-default, python3-rstr, lldb
  llvm-tblgen-native, tailscale
- Add systemd-sysext image class
- Add OrangePi RV2 machine support
- Add Tegra holoscan SDK support
- Add TCOVERRIDE for toolchain selection at recipe scope
- Add whinlatter to compatible layers
- Add support for required TUNE_FEATURES in features_check.bbclass
- Add XFCEBASEBUILDCLASS in xfce bbclass
- Fix several recipes to build with clang from oe-core
- Add ptest support for icu and dosfstools

### Removed

- Deleted recipes - msr-tools
- Remove obsolete 'terminfo' PACKAGECONFIG from clang
- Drop CCACHE_COMPILERCHECK

## [2025.06] - 2025-06-30

### Changed

- Upgrade clang to 20.1.6
- generate preset for templates using systemd bbclass
- Upgrade musl to latest tip of trunk
- Upgrade bind to 9.20.9
- Upgrade ICU to 77-1

## [2025.05] - 2025-05-31

### Changed

- Upgrade GCC to 15.1.0
- Fix several recipes to build with GCC-15
- Upgrade GDB to 16.3 and fix build on mingw
- Fix binutils build for musl target
- Upgrade meson to 1.8.0
- Let wget use libpcre2 and not libpcre
- Upgrade python3-numpy to 2.2.5
- Use virtual/libsdl2 in recipes needing libsdl2
- Refactor qemu.bbclass functions into library functions
- Move clang recipes from meta-clang to core
- Upgrade qemu to 10.x
- Upgrade mesa to 25.0.5
- Adapt recipes to qemu.bbclass refactoring
- Fix ppc32 builds with clang
- Upgrade linux-yocto/6.12 to v6.12.27
- Enable musl based riscv32 in OE-Core
- Update dropbear to 2025.88
- Upgrade openSSH to 10.0p1
- Move libsoup-2.4 to met-oe
- Upgrade go compiler to 1.24.3
- Add option for fips support in openssl
- Upgrade gstreamer to 1.26.1
- Upgrade python3-cython 3.1.0
- Let libglvnd provide virtual packages e.g. libegl
- Upgrade nodejs to 22.16.0
- Switch to using libsoup 3.0 wherever possible instead of libsoup-2
- Upgrade linux-raspberrypi to 6.12.25
- Upgrade clang to 20.1.5 release
- Upgrade mesa to 25.1.0 and add support for asahi drivers
- Upgrade linux-yocto/6.12  to v6.12.30
- Update coreutils to 9.7
- Upgrade QT6 to 1.9.1

### Added

- Add entries for virtual/libsdl2 as default providers
- add recipe for nmap 7.92
- New recipes: blktests, testdisk, libserialmodule, python3-pillow-heif
  socketcand, bvi, libnvfatbin

### Removed

- Remove md5 checksums from oe-core recipes
- Drop supporting 32bit SDK and build hosts
- Removed recipes - xserver-xorg-cvt, gfbgraph, librest
- Remove distutils classes
- Drop dri3 PACKAGECONFIG from mesa
- Remove OSMesa support from mesa

## [2025.04] - 2025-04-30

### Changed

- Add whitespace around assignments in recipes in all layers
- Fix compiler-rt multilib build regression
- Fix recipes to build with GCC 15
- Use go module fetcher for crucible
- Upgrade meson to 1.7.1
- Upgrade gstreamer components to 1.26.0
- Upgrade rust to 1.85.1
- Compile rust llvm to use dynamic libraries
- Upgrade bluez to 5.80
- Upgrade tzdata to 2025b
- Update clang to 20.1.2
- Fix rust compiler and packages to build on riscv32
- Enable NVPTX and SPIRV clang targets
- Migrate several meta-python recipes to use PEP-517 build backend
- Add support for RustiCL to mesa enabled with opencl packageconfig
- Upgrade mesa to 25.0.2
- Update linux-yocto/6.12 to v6.12.23
- Update openssl to 3.5.0
- Upgrade systemd to 257.5
- Fix target rust compiler, cargo and rust packages to build on riscv32
- Remove initramfs-framework's hard dependency with busybox
- Fix whitespaces around assignment operator in several layers
- Update recipes R36.4.0/JetPack 6.1 -> 36.4.3/JetPack 6.2
- Update PHP to 8.4.6
- Upgrde libunwind to 1.8.1
- Add recipes for libsdl3 and libsdl2-compat and define virtual/libsdl
- Upgrade nodejs to 2.15.0
- Switch prefix mapping to use -ffile-prefix-map
- Enable getty generator by default in systemd
- Add pam_env support openssh

### Added

- Added recipes - minizip-ng, python3-typing-inspection, bit7zi, source-highlight
  qhull, b4, libsimplelog, libxmp
- Add support for using alternative runtime D-Bus e.g. dbus-broker

### Removed

- Drop styhead from LAYERSERIES_COMPAT
- Removed recipes: pmtools

## [2025.03] - 2025-03-31

### Changed

- Update linux-hardkernel to latest on hk 4.9 branch
- Add ptests for Wolfssl
- Fix recipes to remove obsolete use of acpaths needed by latest autoconf bbclass
- Fix qtwenengine 6.8 build with clang-20
- Fix WiFi on Raspberry Pi 5
- Upgrade OpenSSH to 9.9p2
- Upgrade rust compiler to 1.83.0
- Upgrade Go compiler to 1.24.0
- Add charconv lib build in boost
- Update Go compiler to 1.24.1
- Use avahi as mdns provider
- Upgrade fluentbit 3.2.1 -> 3.2.8
- Upgrade PHP from 8.2.26 to 8.4.4
- Switch to QT 6.9 release
- Upgrade several Gnome peices to 48 release
- Fix several recipes to build with C23 standard
- Stop allowing non-autotooled recipes to inherit autotools
- Upgrade systemd to 257.4
- Upgrade clang to 20.1.1
- Upgrade protobuf to 5.29.4
- Update linux-yocto/6.12 to 6.12.19
- Update lvgl to 9.2.2 release
- Use https:// in HOMEPAGE variable instead of http:// in several recipes in meta-openembedded
- Upgrade iperf3 to 3.18
- Upgrade PHP to 8.4.5
- Fix several recipes to work with upcoming GCC-15 release with C23 standard defaults
- Update gimp to 3.0 release

### Added

- Added recipes - clpeak, python3-pyasyncore, python3-gpt-image, libsdl3, libsdl2-compat
  minizip, scdoc
- Add support for DNG files in libcamera
- Add clean-hashserver-database script
- Add Jetson Orin AGX to CD pipeline

### Removed

- Removed recipes - iksemel
- Eliminate needless linux-libc-headers and binutils version defaults
- Drop symlinking gold linker in gcc

## [2025.02] - 2025-02-28

### Changed

- Fix several recipes in meta-python to use ptest-python-pytest class
- Correct Licenses for libdvbcsa, fatresize, znc, ndpi
- Upgrade linux-yocto/6.12 to v6.12.11, linux-yocto/6.6 to v6.6.74
- Enable high precision arithmetic support in gawk
- Do not use git submodule fetcher in protobuf
- Upgrade sip to 6.10.0
- Separate out mdns-libnss-mdns package from mdns and rename nss-mdns recipe to avahi-libnss-mdns
- Upgrade opencv to 4.11.0
- Enable '-o pipefail' for the SDK installer
- Upgrade libseccomp to 2.6
- Upgrade Glibc to 2.41
- Upgrade GDB to 16.2
- Upgrade binutils to 2.44
- Enable Sv39 memory address scheme by default for qemuriscv machines
- Upgrade LLVM to 19.1.7
- Upgrade Gstreamer to 1.24.12
- Fix RPI-5/CM5 boot issue
- Enable create-spdx to build SPDX manifests
- Update linux-yocto/6.12 to v6.12.13
- Upgrade python to 2.13.2
- Upgrade Go compiler to 1.22.12
- Switch p7zip to 7zip in classes
- Upgrade musl to latest and fix failing recipes
- Update coreutils to 9.6
- Update OpenSSL to 3.4.1
- Include xz support by default in GDB
- Fix PACKAGECONFIG handling for cross recipes
- Upgrade rust to 1.82.0
- Drop net-tools from busybox defconfig
- Drop ifconfig in favor of ip
- Update uninative to 4.7 which uses glibc 2.41

### Added

- Added recipes - libspdm, spdm-utils, python3-cairocffi
- Add linux-raspberrypi 6.12 recipe

### Removed

- Deleted recipes - pipewire-0.2, linux-yocto/6.6
- Drop ld-is-gold support

## [2025.01] - 2025-01-31

### Changed

- Upgrade nss to 3.107 and nspr to 4.36
- Upgrade bingen-cli to 0.71.1
- Use ptest-python-pytest class in meta-python recipes for ptests
- Upgrade mpd to 0.23.16
- Use go module fetcher for crucible recipe
- Fix recipes in meta-openembedded to build with fmt 11.1.x
- Upgrade QT 6.8 to latest
- Update linux-yocto/6.12 to v6.12.9 and linux-yocto/6.6 to v6.6.69
- Update reference u-boot to 2025.01
- Disable recipes not compatible with boost 1.87 in meta-oe
- Upgrade systemd to 257.1 and enable create-log-dirs
- Upgrade python to 3.13.1
- Upgrade cmake to 3.31.3
- Support usrmerge in toolchain SDK builds
- Lower the length of TMPDIR limit to 400 in sanity class
- Fix absolute paths in go-vendor class
- Upgrade LLVM and Clang to 19.1.7
- Use ptest-python-pytest class in several python package recipes
- Update polkit to 126
- Upgrade mariadb to 11.4.x LTS release
- Switch visionfive2 to efi boot
- Upgrade python3-numpy to 2.2.2
- Switch several recipes using virtual/XXX-gcc to virtual/cross-cc
- Upgrade rust to 1.81.0
- Update rust data layouts for ppc , riscv64 , aarch64 and loongaarch64 targets
- Fix ??= bitbake operator for variable flags
- Fix include poisoning GCC patch to be fatal again in gcc/g++
- Bump swupdate to release 2024.12.1
- Update tzdata to 2025a
- Upgrade GDB to 16.1
- Upgrade Go compiler to 1.22.11

### Added

- Add new recipes - libheif, yyjson, ctre, jsoncons, cxxopts,
  pistache, spectre-meltdown-checker, python3-nanobind
  python3-lief, cheese, opencl-cts
- add Go mod h1 checksum support to bitbake fetcher
- Add UBI support to initrdscripts
- Add support for qemuriscv64 and qemuriscv32 to formfactor
- Add a new class to consolidate pytest ptest functionality
- Add squish support to QT6

### Removed

- Remove ACLOCALDIR and ACLOCALEXTRAPATH from autotools class
- Remove recipe - blktool, mozjs-115

## [2024.12] - 2024-12-31

### Changed

- Upgrade openssl to 3.4.0
- Upgrade gnu-efi to 4.0.0
- Improve bitbake's setscene performance
- Enable GCC sanitizers for riscv64
- Fix Qt5/6 wireshark configuration
- Add 6.12 linux-yocto reference kernel
- Upgrade 6.6 kernel to v6.6.64
- Upgrade curl to 8.11.1
- Upgrade linux-raspberrypi-6.6 to 6.6.63
- Fix external kernel modules for 6.12 kernel e.g. emlog, vboxdrivers
- Upgrade LLVM and Clang to 19.1.6
- Introduce recipe for libpeas 2.x and make it cohabit with libpeas-1
- Update XFCE base components to 4.20 release
- Revert python3-numpy from 2.2 back to 2.1
- Upgrade Qemu to 9.2.0
- Upgrade systemd to 256.9
- Add linux-yocto 6.10 to meta-tegra
- Upgrade musl to latest master at 61399d4bd02ae1ec03068445aa7ffe9174466bfd
- Run aclocal cleanup on expect,tcl,bash recipes
- Use 7zip 24.09 to replace p7zip 16.02
- Add fido and apparmor packageconfigs to systemd
- Upgrade meson to 1.6.1
- Drop debug tweaks setting from meta-odroid
- Update VisionFive2 SDK to JH7110_VF2_6.6_v5.13.1
- Update VisionFive2 kernel to 6.6.20
- Bump OpenSBI to 1.6

### Added

- Added recipes - pam-radius, lua-lgi, cbindgen
- Add include_all conf file bitbake directive

### Removed

- Removed recipes - xserver-common, autoconf-2.13-native
- Remove gpe bbclass
- Drop linux-yocto 6.10

## [2024.11] - 2024-11-30

### Changed

- Refresh FILESEXTRAPATHS for meta-oe recipes
- Upgrade bluez to 5.79
- use lz4 instead of lz4c in bitbake compress
- Upgrade busybox to 1.37 and refresh defconfigs
- Selectively enable GObject introspection in libgpiod
- Don't use debug-tweaks in image features
- Add ptests for openvpn
- Fix gdm to launch with plymouth
- Set CVE_PRODUCT for libestr, librelp, rsyslog, libfastjson
  u-boot, tcpdump, net-snmp
- Inherit cython class in several recipes
- Package libswupdate into separate package
- Add TEGRA_UEFI_MINIMAL support
- Update linux-yocto/6.6 to v6.6.62
- Require lz4 instead of lz4c in bitbake.conf
- Update kernel-devsrc to 6.12+
- Upgrade rust to 1.80.1
- Add itstool-native dependency to several recipes in meta-gnome
- Start using 6.12 for linux libc headers
- Fix taisei, keepalived build on musl
- Fix several recipes to work with ICU-76
- Disable ARM64_SME in linux-yocto
- Fix GCC build with tzdata 2024b
- Fix weston-init to work with seatd
- Fix qemu build for riscv64/musl and upgrade to 9.1.1
- Upgrade systemd to 256.8
- Upgrade LLVM to 19.1.4
- Use the new xserver-abi.inc to generate Xserver ABI dependencies
- Update clang to 19.1.4 release

### Added

- Added recipes for - drm-info, asyncmqtt, swagger-ui
  python3-rouge-score, python3-nltk, python3-fuse
  raspi-utils4, canopenterm, pocketpy, libpanel, libdex
  python3-mlcommons-loadgen, python3-inline-snapshot
  python3-black, python3-scikit-build-core, pytesseract
- Add recipes for tcl/tk 9.0 and tcl/tk 8.x to live side-by-side
- Add cython bbclass to abstract cython usage during build
- Add SECURITY.md file to various layers

### Removed

- Removed debug_tweaks image feature
- Drop unnecessary SRC_URI md5sum from the recipes in meta-oe
- Drop support for BB_DANGLINGAPPENDS_WARNONLY
- Remove python3-isodate

## [2024.10] - 2024-10-31

### Changed

- Fix all enabled ptests for meta-multimedia layer
- Enable go plugins to build in netdata
- Upgrade systemd to 256.6
- Enable systemd-boot on RISCV64
- Update linux-yocto/6.10 to v6.10.14 and linux-yocto/6.6 to v6.6.54
- Update llvm from 18.x to 19.x
- Upgrade OpenSSH to 9.9p1
- Use clang to build u-boot
- Fix useless rpaths in several recipes
- Updat egdb to 15.2
- Several fixes for python 3.13 migration
- Update Gnome components to version 47
- Fix ptests in meta-filesystems and meta-multimedia
- Upgrade clang to 19.1.2 release
- Fix several recipes to work with python 3.13
- Drop unnecessary SRC_URI md5sum in meta-python
- Fix do_fetch error for vlock and wireguard-tools recipes
- Upgrade musl to latest SHA 047a16398b29d2702a41a0d6d15370d54b9d723c
- Upgrade Qt6.8 recipes to latest on 6.8 release
- Fix LLDB python path in SDK
- Fix several ineffective overrides in meta-clang
- Change references to search.cpan.org to use metacpan.org in meta-perl
- Use CPAN_MIRRORS for several recipes in meta-perl
- Fix upstream status tags for beagleV kernel and uboot patches
- Update busyvbox to 1.37
- Update python to 3.13
- Update meson to 1.6.0
- Update gnome componets to 47.1
- Disable perl support in graphviz
- Fix ptests in meta-python to work with python 3.13
- Add ztd compression type option to SDK_ARCHIVE_TYPE
- Upgrade go compiler to 1.22.8
- Uphgrade systemd to 256.7
- Drop openssl/riscv workarounds to add libatomic

### Added

- Added recipes for - fastfloat, glad, python3-pytest-codspeed
  tomlplusplus, snapper, tegra-cuda-utils
- L4T R36.4.0/JetPack 6.1 support
- Add class for building Unified Kernel Images (UKI)
- Add WIC_SECTOR_SIZE variable to wic
- Add tegra support for linux-yocto 6.10 kernel

### Removed

- Removed VOLATILE_TMP_DIR and VOLATILE_LOG_DIR
- Drop unnecessary SRC_URI md5sum entries in meta-perl
- Skip rust setftests on all MIPS platforms
- Removed recipes - python3-whoosh

## [2024.09] - 2024-09-30

### Changed

- Fix systemd to not set polkit permissions manually
- Support testing over serial connection in textexport
- Always use BFD linker to build u-boot
- Fix several recipes to build with Clang-19
- Fix more buildpaths QA error in meta-openembedded
- Update QT6 to latest on 6.7 series
- Update bpftrace to 0.21.2
- Switch to support 'styhead' ( yocto 5.1 ) release codename
- Fix license field to reflect current state in several recipes
- Update linux-yocto v6.6.50, v6.10.8
- Fix python3-cude build breaks
- Fix python3 ptest runs on some recipes
- Use KMS instead of FKMS on pi4/pi5 non-eglfs distros
- Upgrade Clang to 19.1.0 major release
- Fix several recipes to build for RISCV32 architecture
- Switch QT6 to 6.8 release
- Upgrade glib-2.0 to 2.82.1
- Upgrade gtk4 to 4.16
- Upgrade OpenCV to 4.10
- Use GNU C++ runtime for building vte
- Fix all ptest failures in meta-python layer

### Added

- Added recipes - libspelling, imx-cst, freeipmi, valkey
  python3-trio, python3-python-multipart, python3-outcome
  python3-pdm-build-locked, python3-starlette python3-setproctitle
- Add gomodule fetcher
- Add genimage support

### Removed

- Drop TCLIBCAPPEND
- Removed cmem and ti-osal recipes

## [2024.08] - 2024-08-31

### Changed

- Fix native builds for sanitizer version of compiler-rt
- Upgrade linux-yocto 6.6 to 6.6.45
- Update linux-kernel-headers to 6.10
- Update linux-yocto/6.10 6.10.3
- Fix clang compiled apps reproducibility issue w.r.t. clang version
- Switch several python recipes to use PEP-517 build backend
- Fix buildpaths build QA error in several recipes
- Add UPSTREAM_CHECK_COMMITS to meta-openembedded recipes
- Upgrade go to 1.22.6
- Upgrade rust to 1.79.0
- Upgrade GCC to 14.2
- Upgrade binutils to 2.43
- Set CVE_PRODUCT in several recipes
- Use imx-boot from NXP 6.6.23-2.0.0 BSP
- Pin weston to 12.0.4.imx for IMX
- Upgrade systemd to 256.5
- Upgrade rust to 1.78
- Fix reproducibility issues in several meta-openembedded recipes
- Set umask to 0022 on build directories on bitbake invocation
- Upgrade binutils to 2.43.1
- Fix QT 6.7 builds with Clang-19
- Upgrade libxml2 to 2.13.3 and address ABI breakges due to it in meta-oe
- Fix several multimedia recipes to work with ffmpeg 7
- Fix recipes to work with fmt 11.x
- Correct LICENSE field  of several recipes in meta-python
- Upgrade musl to latest on trunk 1.2.5+
- Upgrade automate to 1.17
- Add swupdate OTA support on tegra platforms

### Added

- Introduce 6.10 reference kernel
- Added vex class for CVE management
- Added recipes:
  - drgn, vdpauinfo, python3-psycopg, libplacebo, cpuset

### Removed

- Removed VOLATILE_TMP_DIR and VOLATILE_LOG_DIR bitbake variables

## [2024.07] - 2024-07-30

### Changed

- Fix several packages to build with clang fortify and glibc 2.40
- Add ptest support for unbound
- Stop overriding unprefixed *FLAGS variables for native and nativesdk
- Update linux-yocto/6.6 to v6.6.35
- Use objdump instead of readelf to compute SONAME during image generation
- Adjust metadata to remove True option in getVar calls
- Fix exceptions with -mbranch-protection on ARM64/Libc++
- Enable build-id for systems built with clang compiler
- Upgrade QEMU to 9.0.1
- Update MACHINE in jetson-agx-orin-devkit
- Always use lld linker with clang for qt6 recipes
- Ignore various issues fatal with gcc-14
- Upgrade linux-raspberrypi to 6.6.36
- Pin runtime type to GCC runtime in cuda-gcc and define TOOLCHAIN variable
- Upgrade Go compiler to 1.22.5
- Upgrade systemd to v256
- Upgrade util-linux to  2.40.1
- Enforce default remote name to "origin" in git fetcher
- Enable GTK in OpenCV with wayland as well
- Switch Jetson platforms to use Yoe distro with wayland instead of EGLFS
- Update blueZ to 5.77
- Upgrade GDB to 15.1
- Enable kprobes in tegra kernel
- Add python3-cuda to tegra based images
- Do not manage wifi with systemd-networkmanager
- Disable audit subsystem in kernel for tegra platforms
- Add networkmanager and wireguard to all yoe images
- Fix busybox/tc compilation with 6.9 linux kernel headers
- Fix buildpaths QA error checks in several meta-oe recipes
- Fix several recipes in meta-oe for correct UPSTREAM_CHECK vars
- Update OpenSSH to 9.8p1
- Upgrade to glibc 2.40

### Added

- Added new recipes - libabigail, include-what-you-use, dediprog-flasher
- Added DEBUG_LEVELFLAG variable to contain default debug level e.g. -g1, -g, etc.
- Add packageconfig knob to control tegra gallium driver in mesa
- Add nospdx class
- Add and switch default SPDX version to 3.0
- Add meta-tegra-community layer

### Removed

- Drop generating a static libpython
- Remove /etc/ethertypes in iptables
- Drop obsolete debug compiler option -feliminate-unused-debug-types
- Drop deprecated configs from android-driver.cfg for rpi kernel

## [2024.06] - 2024-06-30

### Changed

- Fix libclc build
- Bump fsl kernel to 6.6.32
- Disable -Wincompatible-pointer-types as error in few recipes
  to build with GCC-14
- Upgrade libcamera to 0.3.0
- Adjust several recipes to build with libtool 2.5
- Update linux-yocto/6.6 v6.6.32
- Upgrade QEMU to 9.0.0
- Upgrade OpenSSL to 3.3.1
- Update wayland to 1.23.0
- Bump QT to 6.7.3
- Fix kernel build for Jetson orin-nano
- Update clang to 18.1.8 release
- Upgrade libgpiod-1.x to 1.6.5 and fix build  with musl
- Upgrade fwupd-efi to 1.6 and move py-pefile to meta-oe
- Allow using LLVM libc++ with GCC compiler
- Move fmt package from meta-oe -> core layer
- Fix libstdc++ unicode header typo regression found with clang
- Update rpidistro-ffmpeg to 5.1.4
- Fix contains reference to TMPDIR [buildpaths] warning in several recipes
- Upgrade PHP to 8.2.20
- Upgrade go compiler to 1.22.4
- Add PACKAGECONFIG for bpf-framework to systemd

### Added

- Added new recipes for - sexpect, trompeloeil, cabextract
  udpcast, python3-typer, magic-enum
- Add ptests support for python3-dasbus, python3-flask
- Add support for BeagleV-Ahead SBC
- Add support for jetson-agx-orin-devkit

### Removed

- remove g77/f77
- drop the old 1.4 bootstrap C version for go compiler

## [2024.05] - 2024-05-31

### Changed

- Upgrade GCC to 14.1 major release
- Enable LLD linker as default for RISCV
- Upgrade strace to 6.8
- Upgrade clang compiler to 18.1.6
- Upgrade nginx to 1.26.0
- Fix several recipes to build with GCC-14
- Refactor composefs recipe
- Fix visionfive2-pvr-graphics sysvinit support
- Fix milkv-duo support in meta-riscv
- Update recipes in multiple layers for UNPACKDIR migration
- Update recipes to move away from S = WORKDIR assignments
- Introduce GO_SRCURI_DESTSUFFIX for go based recipes
- update Simple IoT to v0.16.0
- default `IMG_VERSION` to Yoe release: 2024.04 -> 24.04.x
- add `ca-certificates` to `yoe-simple-image`
- Upgrade valgrind to 3.23.0
- Upgrade QT6 to 6.7.2
- Upgrade vulkan SDK to 1.3.283.0
- Upgrade spirv-llvm-translator 18.1.0
- Fix renaming of network interfaces on rpi projects using systemd
- Upgrade go to 1.22.3

### Added

- Introduce UNPACKDIR bitbake variable
- New recipes
  - glib-testing, opentelemetry-cpp, malcontent
    python3-dasbus

### Removed

- Removed recipes
  - orrery, libtirpc126, usbinit, libomxil
- Drop using LLVMVERSION
- Drop unused 5.15 linux-raspberrypi version

## [2024.04] - 2024-04-30

### Changed

- Upgrade webkitgtk3 to 2.44
- Fix packaging conflicts between mesa and mesa-pvr for RISCV64
- Upgrade linux-yocto to v6.6.23
- Upgrade gstreamer to 1.22.11
- Fix openssl crash on aarch64 w/o crypto instructions
- Accomodate llvm in readelf and objdump commands in oe packaging
- Enable OPTEE for var-som-mx8 project
- Upgrade Golang to 1.22.2
- Upgrade webkit to 2.44.0
- Fix ptests for several meta-openembedded recipes
- Update QT6 to latest 6.7
- Upgrade clang compiler to 18.1.3
- Switch to use http/https instead of ftp in SRC_URIs
- Update linux-variscite to include DT fix to enable PCIE
- Upgrade clang to 18.1.4
- Support 6.6 kernel and u-boot 2024.04 on upstream odroid machines
- Update several gnome components to 46.1
- Add GPT partition names to partitions on rockchip machines
- Fix ptest runs for pv, psqlodbc, unixdoc, ostree
- Add fido2 support to openSSH
- Make predictable name mac policy opt-out in systemd

### Added

- New Recipes
  - highway, libjxl, python-libusb1, libfido2, avro-c++, python3-flexcache
    python3-flexparser, composefs, aravis, ydotool

### Removed

- Removed recipes
  - libxml++, python3-websockets

## [2024.03] - 2024-03-31

### Changed

- Adjustments for bmap-tools -> bmaptool rename
- Major update of clang compiler to 18.1.2
- Add fixes to build recipes with clang-18
- Upgrade vlc to 3.0.20
- Fix reproducibility issues in gnome recipes
- Fix several recipes to work with libxml2 2.12+
- Upgrade PHP to 8.2.16
- Upgrade systemd from 255.1 -> 255.4
- Bump Go compiler to 1.22
- Upgrade GDB to 14.2
- Update linux-yocto to v6.6.22
- Add ptests to several python recipes
- Upgrade LVGL to 9.0 major release
- Upgrade to using QT 6.7.1 in yoe-kiosk-browser
- Update to use 6.1 kernel on all IMX8/IMX9 projects
- Fix var-som-mx8 project to use 6.1 kernel
- Generate versioned shared libraries from LVGL
- Upgrade frr to latest on 9.1 stable
- set TNSPEC_BOOTDEV_DEFAULT for jetson-orin-nano-devkit
- Upgrade some portions of Gnome to 46.0
- Add linux-raspberrypi 6.6 LTS kernel recipe and default to it
- Update meta-tegra to use R35.5.0 nvidia SDK
- Upgrade golang compiler to 1.22.1
- Update to LLVM 18.1.1
- Fix vala to work with gtk < 4.14
- Use +nocrypto with -mcpu compiler options for rpi3/rpi4
- Fix qttools 6.x build with clang
- Update simpleIOT to 0.15.3
- Fix libcamera crashes due to clang patches
- Fix musl builds for openflow, liburing, tracker-miners, libcamera plocate
- Bump linux-raspberrypi to 6.6.22
- Add rpi hifiberry-dacplusadc overlay
- Add apache preset mpm=prefork by default

### Added

- Add new recipes

  - python3-wsproto, python3-httptools, python3-a2wsgi python3-a2wsgi,
    python3-responses, python3-pytest-localserver python3-tomli-w,
    python3-invoke, python3-icecream python3-types-python-dateutil,
    python3-freezegun buildtools-imagemagick, spandsp, sngrep, bluez-tools
    freerdp3, python3-dbus, msgraph, gtk4mm, aer-inject microsoft-gsl, libcpr,
    gnome-user-share

- Add genericarm64 MACHINE

### Removed

## [2024.02] - 2024-02-29

### Changed

- Update linux-raspberrypi to 6.1.74
- Fix VisionFive2 u-boot and linux kernel builds with GCC-14
- Fix support for large rootfs on tegra platforms
- Fix several packages to build with GCC-14 and clang-18
- Upgrade linux-yocto-dev to 6.8+
- Avoid using -march when -mcpu is chosen for armv8/armv9 architectures
- Update Golang to 1.20.13
- Update pseudo to pull in gcc14 fix and missing statvfs64 intercept
- Upgrade OpenSSL to 3.2.1
- Upgrade glibc to 2.39
- Upgrade binutils to 2.42
- Upgrade linux-yocto to v6.6.18
- Improve running default image ptests on RISCV
- Upgrade opkg to 0.6.3
- Fix build race in xfstests
- Fix compiler-rt sanitizers build
- Make clangd compilation optional
- Update LLVM to 18 RC2
- Upgrade openSSH to 9.6p1
- Update mesa to 24.x release
- Upgrade valgrind to 3.22.0
- Fix various python pieces to work with python 3.12
- Update layers for scarthgap release to be series compatible
- Switch meta-python repcipes to use pytest --automake enmass
- Upgrade linux-raspberrypi to 6.1.77
- Enable RTC in RISCV qemu kernel configs
- Fix yocto compatible status for meta-clang
- Fix dav1d build on RISCV
- Improve vscode IDE support
- Add images to enable BBCLASSEXTEND parallel execution for meta-networking,
  meta-multimedia, meta-filesystems layers

### Added

- New packages - python3-moteus, python3-google-auth-oauthlib, python3-janus
  flatcc, python3-aiohappyeyeballs, bonnie++. e2tools, python3-strenum
  python3-httpx, python3-httpcore, python3-sniffio, python3-anyio
  python3-socksio, python3-pyyaml-include, whitenoise, wavemon, libdaq, snort3
  sdmon, python3-looseversion
- Add cortexa78 tune files

### Removed

- Remove meta-elm-binary layer, its not needed anymore for simpleIOT
- Delete LLVMVERSION
- drop using PYTHON_PN variable
- Removed recipes - libencode-locale-perl, libencode-perl

## [2024.01] - 2024-01-31

### Changed

- Fix llvm-config to work in cross-compilation environment
- Fix several recipes to work with python 3.12
- Update rust compiler to 1.74.1
- introduce 6.6 reference kernel and make it default for Qemu machines
- Update linux-kernels to v6.1.70 and v6.6.9
- Require bitbake 2.7.1 minimum
- Update mesa to 23.3.2
- Update visionfive2 firmware to JH7110_VF2_6.1_v5.10.3
- Disable mongodb build until its ported to python 3.12
- Add udev-bash-completion package to systemd
- Upgrade reference u-boot to 2024.01
- Use pkg-config in the meson cross files
- Backport opkg fix to drop --numeric-owner parameter
- don't exclude gtkdocize in autotools class, fix several recipes to inherit
  gtk-doc
- Distable incompatible-function-pointer-types warning as error with clang 17 on
  python3-lxml and python3-kivy
- Update VisionFive2 u-boot to JH7110_VF2_6.1_v5.10.3
- Fix evolution-data-server fallout with inherit_defer
- Add check for rv32 musl support being absent in Core layer
- Undo the musl/rv32 host compatible check in meta-riscv
- Update weston to 13.0.0
- Update autoconf to 2.72d -> 2.72e
- Fix openssl build on riscv32
- Update to python 3.12 major release
- Improve go-vendor support in recipetool
- Add build time QA check for "virtual/" in RPROVIDES and RDEPENDS
- Fix the mozjs-115 build on ARMv5
- Update linux-yocto versions to v6.1.73, v6.6.12
- Upgrade uftrace to 0.15.2, adds support for rust and python
- Add ptest support for xz
- Upgrade rpm to 4.19.1
- upgrade systemd to 255.1
- Upgrade Qemu to 8.2.0
- Update QT6 to 6.6.2 and add build fixes to QTWebengine with latest clang

### Added

- New recipe - ssd1306, dropwatch, python3-apscheduler
- Added machines - orangepi-5-plus, rock-4c-plus, rock-3a, roc-rk3308-cc
  roc-rk3328-cc, Raspberrypi5
- Add Darwin platform support to cmake class
- Add a new `inherit_defer` keyword support to bitbake
- add devtool support for multiple source in SRC_URI
- Add new project for rpi4 32bit machine

### Removed

- Removed recipes: zvariant, polkit-0.119, mozjs-102, python3-jsonrpcserver
  python3-oslash, python3-kmod, python3-xmlrunner, linux-yocto/6.1

## [2023.12] - 2023-12-30

### Changed

- Fix mesa-gl conflict with mali-g31 driver KHR/khrplatform.h header
- Enable utmp support in busybox on musl systems
- Support qemu for cmake via cmake-qemu.bbclass
- Update clang to 17.0.6
- Disable lld for x32 ABI, it does not have support
- Upgrade autoconf to 2.72d
- Unset CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES in cmake
- Upgrade rust to 1.71.1
- Update go compiler to 1.20.12
- Update linux-yocto versions to v6.1.68, v6.5.13
- Prepate several recipes for working with python 3.12
- Fix meta-tegra to build with musl
- Use clang to compile openSSH again
- Fix build issues in bpftrace ptests
- Add ptests for c-ares
- Switch to 6.1 kernel for linux-starfive from 3.9.3 SDK
- Ensure features don't get backfilled for nativesdk
- Switch to using zstd compression in core layer
- Update gdb to 14.1 release
- Fix several packages to use right basename POSIX or GNU option

### Added

- Added recipes - monocypher, xorg-docs, xcursor-themes python3-maturin, cyaml,
  pkcs11-provider
- Devtool now supports git submodules for SRC_URI
- Add python recipe writing support to recipetool
- Add python maturin support
- Add project for jetson-orin-nano with NVME boot media

### Removed

- Removed recipes - vte9, systemtap-uprobes
- Remove unused SRC_DISTRIBUTE_LICENSES variable
- Drop removed IMA option from linux-yocto

## [2023.11] - 2023-11-30

### Changed

- Revive patchreview script
- Add python_hatchling support to recipetool
- Upgrade QEMU to 8.1.2
- Drop dependecy on libcroco in openbox and gnome-shell
- Update QT6 to 6.6.2
- Upgrade clang to 17.0.5
- add nativesdk version of acpica
- Use correct targets for rust binaries in meson
- Update openSBI to 1.3.1
- Update linux-yocto/6.5 to v6.5.9 and linux-yocto/6.1 to v6.1.60
- Fix arm arch mapping issues in libdnf
- Fix ODROID-C4 broken SD cards by dropping use of IMAGE_NAME_SUFFIX
- Upgrade linux-hardkernel-4.9 to latest upstream
- Fix WKS_FILE assignment which lets it use yoe wks template now
- Pin minimum kernel to 4.9 for C4
- Fix librsvg for RISCV32 architecture
- Fix libarchive build inconsistency w.r.t. libb2 presence
- Fix ptest-packagelists for RISCV32
- Fix spidev-test on kernel 4.9
- Add ptest support to nlohmann-json
- Use meson as default buildsystem for gnomebase.bbclass
- Adjust recipes in meta-openembedded to work with meson defaults for
  gnomebase.bbclass
- Obsolete dleyna related recipes
- Update linux-raspberrypi to 6.1.61
- Add systemd startup to yoe-kiosk-browser to run it usin linuxfb
- Add G31 mali driver and make it work with ODROID-C4
- Update rpi-config to tip of tree
- Fix mesa-gl build with LLD
- Drop PE, PR from /usr/src/debug paths in recipes from multiple layers
- Use nonarch libdir for tmpfiles.d in multiple recipes
- Process installed dependencies in deterministic order during staging
- Add sysvinit to distro features when using busybox init system
- Fix mesa for ODROID-C4 with G32 Mali userspace driver
- Upgrade gstreamer to 1.22.7
- Add minimal configuration for VS Code
- Add htop to yoe-simple-image

### Added

- Add nanopi-m4b machine
- Added recipes for:
  - python3-pcodedmp, python3-olefile, python3-oletools
  - python3-multivolumefile, python3-pymemcache, python3-jsbeautifier
  - python3-inflate64, python3-colorclass, python3-rarfile
  - reptyr, python3-unoconv, python3-screeninfo, python3-zopeevent
  - python3-flask-restx, exiftool, python3-pdm, python3-pdm-backend
  - python3-wand, python3-py7zr, python3-pyppmd, python3-pybcj
  - bindfs, kmsxx, python3-file-magic, btop
- Add KAS support in meta-riscv
- Add handler to create go recipes Add go-vendor class
- Add recipetool handler to create go recipes
- Add initial support to use RISCV64 build host
- Add websocket support and SQLalchemy hashserv backend in bitbake
- Add new project for orin nano tegra board
- Add initial support for Milk-V Duo board
- Add new project for NVIDIA jetson orin-nano

### Removed

- Remove ${CCACHE} from FORTRAN compiler in bitbake config file
- Removed recipes - libcroco, netkit
- Drop obsolete SERIAL_CONSOLES_CHECK for all machines
- Dropped recipes:
  - python3-nacl, toscoterm

## [2023.10] - 2023-10-30

### Changed

- Upgrade clang to 17.0.3
- Fix libcgroup and kernel-selftest to build with lld linker
- Fix ptest images to match core layer naming convention
- Fix ptest reporting issues in meta-oe packages
- Upgrade mason to 1.2.2
- Upgrade u-boot to 2023.10
- Add 6.5 kernel and switch to using it as default for qemu machines
- Add kernel-selftest to slow ptest image for x86 and enable bpf tests
- Upgrade cryptodev to build with kernel 6.5
- Use ttyrun to get getty on busybox init and sysvinit init systems
- Add static-passwd and static-group files for meta-openembedded layers
- Fix ptest failures in poco, libtevent, and libnet-idn-encode
- Add ptests for libldb, cjson, re2
- Upgrade linux-yocto recipes to v6.1.57, v6.5.7
- Upgrade go compiler to 1.20.10
- Upgrade curl to 8.4.0
- Fix ptests for python3-py-cpuinfo and python3-pytest-mock
- Add ptest for libtext-diff-perl
- Update QT6.5 to latest
- Upgrade openSSH to 9.5p1
- Update dtb path for qemuarmv5 in linux-yocto 6.5 onwards
- Fix pvr drivers to work with musl on visionfive2
- Fix pvr visionfive2 drivers on musl
- Update nodejs to 20.8.1
- Make systemd packaging more granular
- Replace RUNTIME variable with TC_CXX_RUNTIME
- Do not set powersave as the default CPU governor in linux-raspberrypi
- Update simpleIOT to 0.13.1
- Switch to using QT 6.6
- Update ostree to 2023.7 and add ed25519-openssl support

### Added

- Added recipes - tayga, ttyrun, python3-arrow, python-git-pw
  - libexosip2, libosip2, pcapplusplus
- Add bblock feature to core
- Add Yoe updater support for VisionFive2 board

### Removed

- Dropped recipes for linux-yocto/6.4, po4a, debsums
- Remove bitbake-whatchanged bitbake utility
- Drop DEPLOY_DIR_TAR variable

## [2023.09] - 2023-09-30

### Changed

- Reset DOCKER_REPO inside interactive docker shell
- Add glibc 2.38 stable updates
- Switch glib-networking to use gnuTLS for TLS needs
- Fix KCONFIG_CONFIG_COMMAND in menuconfig task
- Fix python, tcl ptest runs on musl
- Fix multilib builds of few packages in meta-oe
- Fix several packages to build for non-neon arm targets
- Fix multilib support in clang to search lib32
- Fix fetching bcc recipe to not modify .gitconfig on build host
- Explicitly disable JIT in webkitgtk for armv7\* with softfp
- Fix rust targets for ppc64 architecture
- Improve loongarch support in go compile and gcc toolchain
- Update linux-yocto/6.4 to v6.4.14 and 6.1 to v6.1.51
- Upgrade qemu to 8.1.0
- Review CVE_STATUS for kernel vulnerablity list
- Fix several ptests in core to work on musl
- Upgrade weston to 12.0.2
- Switch to using "nanbield" layer series compat
- Update VisionFive2 SDK to V3.6.1
- Fix -fstack-protector GCC on aarch64
- Mark RISCV32 incompatible architecture in goarch.bbclass
- Upgrade coreutils to 9.4
- Add ptest support to mariadb
- Enable 64 bit shell arithmetic in busybox, helps 64bit time_t
- Fix build race in piglit and groff
- Use mtime checks instead of inotify in bitbake
- Use 64 bit integers across all targets in perl
- Upgrade clang to 17.0 major release series
- Upgrade gnome recipes to 45.0
- Update linux-raspberrypi kernel to 6.1.54
- Update OpenSSL to 3.1.3
- Improve oeqa/runtime/parselogs
- Enable yocto sstate feed server
- Upgrade to systemd 254.4
- Reduce debuf info size of webkitgtk3 and webkitgtk
- Fix mesa to build with LLVM 17
- Fix recipes to build with kernel 6.5
- Add missing upstream status for all recipes in meta-openembedded
- Update nodejs to 20.5.1
- Bump VF2 SDK to v3.7.5

### Added

- Added new recipes
  - microcom, vsomeip, libei, python3-apiflask python3-webargs,
    python3-flask-httpauth, python3-apispec python3-flask-marshmallow,
    webrtc-audio-processing, python3-flask-jwt-extended tecla, python3-pyu2f,
    python3-uritools, python3-beartype, musl-legacy-error python3-spdx-tools,
    python3-flask-cors, python3-boto3, python3-botocore python3-nacl
- Add gpt-hybrid partition layout to wic
- Enable generating spdx manifest by default

### Removed

## [2023.08] - 2023-08-31

### Changed

- Move projects to toplevel conf directory
- Implement new project detection logic in envsetup
- Upgrade Simple IoT to v0.12.2
- Fix dependencies for yoe-kiosk-browser
- Convert CVE_CHECK_IGNORE to CVE_STATUS in meta-openembedded
- Fix cross builds for python3-pyaudio
- Enable wayland/x11/opengl configs based corresponding distro features in
  mesa-pvr
- Move libadwaita to core layer
- Move gcr3 to meta-oe
- Upgrade systemd to 254
- Upgrade FSL graphics stack to 6.4.11.p1.2 BSP release
- Use libgpiod 1.x for VAR-SOM based projects e.g. var-som-mx8
- Switch Qemu based projects to use QT6 instead of QT5
- Upgrade musl to tip of trunk
- Upgrade binutils to 2.41 release
- Fix syntax error in image_types_sparse
- Bump libcamera to latest tip of trunk
- Fix conversion errors in cve_check
- Fix poco ptests run
- Fix ptests runs on qemu inside container
- Do not use lld on riscv with binutils 2.41
- More LLD fixes e.g. elfutils and gnu-efi
- Use yoe-kiosk-image instead of yoe-qt5-image for CI
- Bump libcamera-apps to latest
- Do not use internal assembler with clang for qtbase
- Restart yoe-kiosk-browser service on failure
- Update linux-yocto/6.4 to v6.4.11 and 6.1 to v6.1.46
- Pass /dev/vhost-net to build container from envsetup
- Upgrade openssh to 9.3p2
- Upgrade go compiler to 1.20.7
- Fix recipe_sysroot_check_ld_is_lld to not trigger on allarch recipes
- Fix rust features for vfpv3d16
- Adjust commman to work with interface renaming with kernel 6.4 and systemd 254
- Switch RPI4 to use QT6
- Wrap more bitbake commands in container e.g. bitbake-getvar
- Enable i2c and disable rpi boot logo for rpi4-64
- Add needed host SDK bits for QT6 to yoe-kiosk-image
- Define SRCREV_FORMAT for recipes with multiple git SRC_URIs
- Upgrade to glibc 2.38
- Upgrade openSSL to 3.1.2
- Fix unnessary clang rebuild when enabling MULTILIBS
- Add ptests to librelp and run them by default in meta-oe ptest image
- Upgrade mariadb to 10.11.5
- Fix musl build for riscv32
- Allow building some native recipes with ccache
- Do not use LLD linker to build go-runtime on aarch64, subsequent apps linking
  with this go-runtime crashes go linker
- Switch from GNU-TLS to openssl transport by default on rsyslog
- Update to latest on QT6 6.5 LTS
- Improve taskhash reproducibility in bitbake/siggen
- Add new srcrev fetcher API to fetch2
- Disable perl support in perf
- Do not define TESTIMAGE_AUTO for qemu machines
- Fix allarch override syntax in cmake class
- Fix recipes to work on arm without neon systems
- Update contribution guidelines
- Upgrade cmake to 3.27.4
- Increase python thread stack size to 2M on musl

### Added

- Added recipes
  - webkitgtk3, libnvme, python3-telnetlib3, mstpd, bolt python3-types-psutil,
    python3-types-setuptools, qad ttf-google-fira, python3-oauth2client,
    python3-schedule spice-guest-vdagent, aml, phodav, gnome-boxes, libosinfo
    gnome-remote-desktop, libcacard, usbids, qcbor python3-sdbus, libfaketime,
    python3-piccata, python3-gspread
- Add script to generate kernel CVE_STATUS entries for linux-yocto
- Add packageconfig to support colored logs in journald
- Add DOCKER_PORTS variable in setenv to forward ports between docker and host
- Add GCP fetcher to list of supported protocols
- Add yocto sstate mirror as default backup for public sstate feeds
- Add MESON_TARGET to meson class which can be defined in recipes
- Add DOCKER_EXTRA_ARGS to envsetup to pass custom options to docker
- Add vfat image type

### Removed

- Remove version-going-backwards from build QA errors
- Remove unused AUTHOR variable from recipes in meta-openembedded and core

## [2023.07] - 2023-07-31

### Changed

- Fix parallel build issue with external modules on visionfive2
- Move xcb-util-cursor from meta-oe to core layer
- Upgrade ostree to 2023.5
- Upgrade bcc to 0.28.0
- Update visionfive2 SDK components to V3.1.5
- Upgrade openCV to 4.8.0
- Upgrade bpftrace to 0.18.0
- Upgrade linux-raspberrypi to 6.1.38
- Update linux-yocto 6.1 to v6.1.38 and 6.4 to v6.4.3
- Upgrade bluez5 5.66 -> 5.68
- Enable JIT on RISCV64 for webkitgtk
- Add -Wl,--undefined-version when using lld for few recipes
- Upgrade opkg to 0.6.2
- Upgrade go compiler to 1.20.6
- Improve pybootchartgui rendering
- Add -mbranch-protection=standard for all aarch64
- Configure gcc without --enable-standard-branch-protection
- Upgrade qemu to 8.0.3
- Upgrade linux-firmware to 20230625
- Add rust selftests
- Fix network restrictions for glibc-testsuite ptests
- Add the disable-wifi overlay for RPI machines
- Improve glibc testing over nfs root
- Upgrade GCC to 13.2 release
- Upgrade autoconf to 2.72c
- Fix freertos-variscite compile failure when do_compile is rerun

### Added

- Added recipes - python3-pyqt5, python3-pyqt5-sip, python3-pyqt-builder wtmpdb,
  lastlog2
- Yoe logo in psplash

### Removed

## [2023.06] - 2023-06-30

### Changed

- Add missing run-time dependencies in several python recipes
- Stop using PYTHON_PN in several python recipes
- Add 44.2 gnome recipes
- Fix REQUIRED_DISTRO_FEATURES gobject-introspection-data in several recipes
- Upgrade linux-yocto/6.1 to v6.1.35
- Document SPLASH_IMAGES variable
- Do not search host paths for find_program() in cmake.bbclass
- Don't force PAHOLE=false in linux-yocto
- Upgrade OpenSSL 3.1.1
- Enable fullscreen and disable startup-msg in psplash
- Fix spdx license parsing
- Make built-in libtraceevent plugins from perf cohabit with external
  libtraceevent
- Fix vulkan-samples build on 32-bit platforms
- Make OpenSBI FW_TEXT_START=0x40000000 specific to jh7110
- Use python3 in oe-stylize
- Upgrade wireshark to 4.0.x
- remove -fcanon-prefix-map in scp-firmware recipe
- Use IMAGE_LINK_NAME in updater and yoe-initramfs-image
- Upgrade gstreamer1.0 to 1.22.3
- Update rust to 1.70.0
- Switch meta-qt6 to 6.5 branch instead of 6.5.1 point release branch
- Update clang to 16.0.6 tag
- Fix enabling lld as distro linker in clang.bbclass
- Upgrade go compiler to 1.20.5
- Fix recipes to build issues found using lld linker
- Drop setting ARM_INSTRUCTION_SET explicitly, it can build in thumb mode and
  upgrade to 8.2.7
- Use BFD linker for libgcc and glibc explicitly
- Replace Yocto .h by .png splashscreen in psplash
- Add weston user to wayland and render groups
- Upgrade libubootenv to 0.3.4
- Fix several recipes to link with LLD linker
- Use llvm-strip system-wide for STRIP utility for RISCV targets
- Fix ntpd systemd service type forking -> simple
- Fix OpenSBI build for visionfive2 SBC
- Upgrade GDB to 13.2
- Drop using tunctl in runqemu/qemu-helper
- Upgrade python to 3.11.3
- Upgrade mesa to 23.1.1
- Fix gn to build with gcc-13
- Backport fix for linking failures using LLD linker for RISCV
- Migrate to use markdown format for READMEs in meta-openembedded
- Fix vpu and pvr-graphics build and packaging issues on visionfive2
- Bump LLVM in core layer to 16.0.6
- Fix several recipes to build when LLD is default distro linker
- Add Upstream-Status tags to meta-openembedded, meta-rpi, meta-odroid
  meta-freescale, meta-clang and meta-yoe layers
- Add support for mbedTLS v3.x
- Bump QT6 packages to 6.5.3
- Fix weston booting issues on visionfive2 SBC and update to use StarFive SDK
  v3.0.4 components
- Improve patch-status layer filtering in insane.bbclass QA checks
- Update rpi kernel to 6.1.34
- Enable glx/opengl support in gstreamer1.0-plugins-base
- Update python3 to 3.11.4

### Added

- Added recipes - python3-ninja-syntax, python3-lazy, python3-classes
  python3-pypng, stopit, vulkan-validation-layers, python3-meson-python
- Add support for loongarch64 to initramfs
- Add QT6 layer and enable it for var-som-mx8
- Add LGPL-3.0-with-zeromq-exception to common-licenses
- Add python_mesonpy class
- Add new project for VisionFive2
- Add support for Variscite VAR-SOM-MX8M-NANO
- Add layer-<layername> override support
- Enable largefile and 64bit time_t support systemwide for 32 bit platforms

### Removed

- Removed recipes - u-boot-bb.org
- Drop QT5 layer

## [2023.05] - 2023-05-30

### Changed

- Upgrade clang to 16.0.4+
- Fix stale SRC_URI locations in several meta-openembedded recipes
- Drop crosssdk suffix from virtual binutils, gcc, go and clang recipes
- Fix SRC_URI locations for several recipes in meta-openembedded
- Switch to using upcoming debian "bookworm" based container for building
- Enable LoongArch support in clang
- Upgrade lvgl recipes and support wayland and fbdev backends
- Fix buildpath QA errors in many meta-openembedded recipes
- Fix recipes to build without gobject-introspection-data
- Upgrade Gstreamer to 1.22.2
- Update musl to 1.2.4
- Add CPE_NAME to /etc/os-release
- Set minimum required target kernel to 5.15
- Upgrade rust compiler to 1.69.0
- Upgrade QEMU to 8.0.0 and fix ppc32 emulation bug
- Default to https git protocol where possible in SRC_URI
- Add --libfiles option to llvm-config
- Add systemd unit file for etcd
- Uprev libplist to 2.3.0, fix several dependent recipes to support API changes
  from 2.3.0
- Fix rpi-libcamera-apps recipe for ARM64
- Fix linux-bb.org to build with gcc 13
- Fix several recipes in meta-oe to remove TMPDIR in output packages
- Update libfmt to version 10 and fix dependencies to support new APIs
- Use autoconf-archive-native as m4 macros dependencies during build instead of
  target autoconf-archive during build
- Enable zbb manip extensions for rv32/rv64 in ffmpeg build
- Fix few of buildpath issues in meta-openembedded recipes
- Simplify MACHINEOVERRIDES definitions for rpi
- Add missing run-time dependencies in several ptython module recipes
- Mandate gobject-introspection-data DISTRO_FEATURE
- Let clang override the llvm provided by OE-Core
- Remove unused patch files in core and meta-openembedded layers
- Add ptest support to hiredis and uprev to 1.1.0
- Upgrade go compiler to 1.20.4
- Upgrade binutils to latest top of 2.40 branch
- Upgrade zfs to latest master which is 2.1.11+
- Requires gobject-introspection-data DISTRO_FEATURE in dependent recipes
- Update curl to 8.1.1
- Update busybox to 1.36.1
- Upgrade to GCC 13.1

### Added

- New recipes
  - etcd, python3-tomlkit, python3-pytest-mock, python3-calver
    python3-trove-classifiers, python3-platformdirs, python3-uswid
    python3-pefile, libcbor, psutils, libpaper, serial, libisoburn libisofs,
    paprefs, openfortivpn, networkmanager-fortisslvpn mbpoll, python3-bleak

### Removed

- Drop MIPS Edgerouter support
- Removed recipes
  - xorriso, python3-async, linux-yocto 5.15
- Drop lzop from linux-imx defaults

## [2023.04] - 2023-04-29

### Changed

- Fix meta-clang towards meeting yocto layer compatible status
- Fix clang packaging issue where installing clang-tools would pull in whole
  compiler
- Simplify imx-boot container
- Add 6.1 linux-ti-staging
- Update tzdata 2023c
- Make EXCLUDE_FROM_WORLD boolean
- Fix recipes to build with upcoming 2.72 autconf release
- Remove double protocol= from SRC_URIs in meta-oe
- Correct the license information for several recipes in meta-oe
- Update several gnome recipes to 44.0
- Add ptest images for meta-oe, meta-python, meta-perl
- Update rust to 1.68.1
- Add missing dependency on glib-2.0-native in several recipes
- Add fixes to several recipes to build with autoconf 2.72
- Update clang to llvmorg-16.0.1 release
- Fix bindgen-cli and python3-pyruvate to work with new crate updated class
- Fix upstream patch status in meta-webserver, meta-perl, meta-xfce meta-gnome,
  and meta-multimedia
- Improve cargo-update-recipe-crates to specify two different versions of same
  crate in given recipe
- Use 3.20 version for OPTEE components
- Update VisionFive2 firmware to 2.11.5
- Upgrade pipewire to 0.3.68
- Fix recipes to build with multilib on
- Switch beaglebone and beagle-x15 to bb.org kernel/u-boot
- Add support for creating bootable SD card for visionfive2 board
- Use 6.2 for linux-ti-mainline kernel
- Use shlex instead of deprecated pipe in python scripts
- Upgrade u-boot to 2023.04
- Update ffmpeg to 6.0
- Update musl to latest trunk
- Update rust to 1.68.2
- Update FSL u-boot to 2023.04 release
- Update QT5 to v5.15.9-lts-lgpl
- Add new Assimp submodule to qt3d
- Fix visionfive2 wic file generation
- Upgrade systemd 253.1 -> 253.3
- Fix several ptests to work on musl systems
- Fix runtime dependencies for clang scanbuild
- Update linux-yocto to v6.1.25, v5.15.108, v6.1.24
- Fix bunch pf ptests on musl to fix core-image-ptests-fast

### Added

- Add new CVE database fetcher cve-update-nvd2-native
- Added new recipes:
  - libpcsc-perl, polkit-gnome, libnfs, adw-gtk3, etcd-cpp-apiv3
- Add ptests for libtinyxml2, python3-lorem, python3-path and dc bitwise
- Enable hashserve distro-wide for yoe
- Add support for Raspberry Pi Camera Module v3

### Removed

## [2023.03] - 2023-03-30

### Changed

- Upgrade raspberrypi kernel to 5.15.103
- Upgrade linux-yocto to v6.1.20
- Upgrade openSBI to 1.2 and fix cyclic dependency for fitImage based boards
- Create machine-id with "uninitialized" text
- Upgrade simpleIOT to 0.9.0 release
- Refresh fixes for android-tools
- Upgrade linux-hardkernel to 4.9.337
- Upgrade nodejs to 18.14.2
- Enable mesa-demos build with userland graphics drivers on rpi
- Enable kms plugin for visionfive2
- Fix gdb intermittent build issue
- Allow overwrite of QB_CPU for qemux86
- Add PROVIDES and RPROVIDES for virtual/opencl-icd
- Enable --enable-new-dtags in binutils for DT_RUNPATH
- Add missing binutils dependency in glibc
- Yoe updater now supports tmpfs as well as persistent overlays
- Add yoe-installer-image to create SD card installer for eMMC
- Switch to using ext4.xz for rootfs in updater
- Update arm optee-os to 3.20.0
- Upgrade bpftrace to 0.17.0
- Fix serveral recipes in meta-freesclale to build world
- Enable parallel execution of ptest images and fix ptest dependencies
- Handle spaces within user $PATH in SDK installers
- Upgrade systemd to 253.1
- Upgrade visionfive2-firmware to VF2_v2.10.4
- Fix nodejs build on older build hosts eg. centos8
- Move android-tools from meta-clang to meta-oe
- Update openssh to 3.1.0
- Update matchbox recipes to latest
- Upgrade networkmanager to 1.42.4
- Upgrade clang to 16.0.0
- Fix building various packagegroups in meta-openembedded
- Use python3-unittest-automake-output in python recipes for ptest integration
- Fix qtpdf with clang-native from 16.0.0 release
- Update android-tools to 29.0.6.r14
- Disable warnings as errors when building glibc
- Update mesa to 23.0.0
- respect IMAGE_LINK_NAME in seftests
- Upgrade RPI kernel to 6.1
- Fix some linkshared regression introduced in go 1.20
- Upgrade openssh to 9.3p1
- Fix rpi specific vlc and ffmpeg with clang16
- Update clang to 16.0.1
- Fix libunwind compile failures on 32-bit arm with Clang 16

### Added

- Add kernel specific KERNEL_OBJDUMP variable
- Add VOLATILE_TMP_DIR variable
- Add support for visionfive2 board
- Add recipes - python3-rich, xdg-dbus-proxy, libavif, dav1d pgpool2,
  python3-unittest-automake-output, debugedit, reboot-mode python3-executing,
  python3-pure-eval, python3-stack-data exfatprogs
- Add yoe updater support for MX8-VAR-SOM symphony board
- Add ptest support for mbedTLS
- Add buildstats-summary script
- Add support for loongarch64
- Add find-debuginfo support back

### Removed

- Removed recipes - quagga, jhi, exfat-utils

## [2023.02] - 2023-02-28

### Changed

- Update busybox to 1.36, disable SHA accelarators for 32bit x86
- Bundle libc++abi archive into static libc++.a, improves static linking
- Bump kernel to linux-yocto 6.1 for odroid devices
- Add ptest support for python3-pillow
- Fix several recipes to build with upcoming GCC13 release
- Upgrade mongodb to 4.4.18 and fix build with ccache enabled
- Fix recipes to use target python config for target during cross compile
- Pass MAXLINELENGTH to scons invocation, helps with large cmdline lengths
- Upgrade rust to 1.67.1
- Upgrade linux-raspberrypi to 5.15.90
- Add ptest support to gnuTLS
- Upgrade linux-yocto/5.15 to v5.15.91, linux-yocto/6.1 to v6.1.9
- Fix Yoe Updater to use correct boot device after upgrade
- Upgrade glibc to 2.37
- Fix several recipes to work with upcoming gcc 13 release
- Improve on target locale generation
- Fix clang recipe for multilib build
- Enable PIC for static archives with clang runtime libs
- Fix several recipes to build with clang-16/c++17
- Add ptest for minicoredumper
- Add PACKAGECONFIG for video-codecs in mesa
- Provide missing tools during cross compiling openmp
- Sync dtc tree with kernel for nezha/riscv
- Add a PACKAGECONFIG for arm_neon in graphene
- Upgrade gstreamer1.0 to 1.22.0
- Update go compiler to 1.20.1
- Fix wireless on model 3B and Zero W
- Use LLVM_ENABLE_RUNTIMES to build llvm runtime libs
- Speedup nodejs native compilation by not during cross builds
- Improve idle thread exception handling in bitbake
- Do not use xz parallelism options with zstd
- Enable systemd-time-wait-sync.service when timesycd is enabled
- Improve build-appliance-image target
- Upgrade Upgrade to 13.1
- Fix QEMU build with 6.2 kernel headers
- Fix ffmpeg build with vulkan
- Improve resulttool reporting
- Upgrade musl to latest tip of trunk
- Fix Upstream-Status for several patches

### Added

- New recipes
  - python3-pycups, extract-cert, rtkit, system-config-printer rpi-eeprom,
    libdeflate, python-daemon, smemstat, linux-serial-test libgpiod v2.0-rc2,
    python3-gpiod, plocate
- Add initial support for loongarch64 architecture
- Add artifact signing infrastructure class ( signing.bbclass )
- Add weston kiosk shell

### Removed

- Remove rock-pi-4 MACHINE
- Remove image SPDX and index from deploydir
- Remove clang-offload-wrapper from clang, gone in clang 16 as well
- Remove glib site cached values
- Removed recipes
  - crda, linux-yocto-5.19

## [2023.01] - 2023-01-30

### Changed

- Switch to using 'mickledore' for LAYERSERIES_COMPAT
- Fix clang recipes to work without LFS64 functions
- Use gcc to compile pixman on aarch64
- Fix several recipes for 64bit time_t on 32bit arches
- Update musl to latest tip ( drops LFS64 interfaces )
- Use binutils objcopy in BSP linux kernel builds
- Use gcc for all u-boot forks
- Upgrade usbguard to 1.1.2
- Switch qemux86-64 to x86-64-v3 tune
- Include "c" in IMAGE_LINGUAS for glibc
- Upgrade ruby for 3.2.0
- Upgrade curl to 7.87.0
- Switch ostree to use fuse3
- Fix QT5 builds with 64bit time_t
- Update concurrencykit to latest to support RISCV
- Update nezha (rv64 board) support
- Fix EGT recipe to work with clang in meta-atmel
- Improve sstate reuse of llvm-project-sources
- Fix meta-freescale BSP recipes to work with clang compiler
- Fix various python modules to migrate from picobuild to python3-build
- Fix freedom-u540 opensbi dependency loop in meta-riscv
- Improve shutdown handling and lockfile handling in bitbake at exit
- Set ac_cv_sys_file_offset_bits=64 for musl builds globally, enables 64-bit
  off_t on autotool based packages
- Unify rust patches into rust-source.inc
- Update linux-yocto kernels to v5.15.87 and v6.1.5
- Add libgcc to uninative-tarball
- Fix several recipes to work with powerpc32 architecture
- Bump linux-libc-headers to 6.1
- Add webp packageconfig knob for libtiff
- Upgrade rust to 1.66.1
- Improve reproducibility in clang build
- Apply C++17 portability fixes in several recipes
- Fix C++11(Alignof) issues in several packages
- Update clang to 15.0.7
- Update bcc to 0.26.0
- Fix create-spdx handling for clang
- Fix several recipes to work with upcoming GCC 13 compiler
- Fix Upstream-Status format of several patches
- Use 6.1 kernel for Qemu machines
- Upgrade binutils to 2.40
- Upgrade u-boot to 2023.01

### Added

- Added recipes - xdg-desktop-portal-gtk, eog libdecor, biodbc, python3-build,
  python3-pyproject-hooks python3-reedsolo, lvgl-demo-fb, nv-codec-headers,
  webp-pixbuf-loader gnome-chess
- Add GLIBC_64BIT_TIME_FLAGS on ppc/x86
- Introduce v6.1 reference linux-yocto kernel recipes

### Removed

- Removed recipes - boost-url, python3-strict-rfc3339, python3-picobuild
- Remove package_tar.bbclass from classes-global

## [2022.12] - 2022-12-31

### Changed

- Update clang to 15.0.6 and fix build for 32bit LFS64 systems
- Fix compiler and binutils tools options for kernel and u-boot
- Add protocol= explicitly to github SRC_URI for linux-odroid
- Add opengl to REQUIRED_DISTRO_FEATURES in recipes from meta-oe
- Add ipv6 in PACKAGECONFIG to libwebsockets
- Rename gcr to gcr-3 to accomodate gtk4 and dependencies
- Move GTK4 support to core from meta-oe/meta-gnome layers
- Improve reproduciblity patch in go compiler
- Avoid host contamination in go cross SDK compiler
- Update minimum python version needed to 3.8 on build hosts
- Fix several recipes for lfs64 support
- Ports gtk3+ to use meson
- Update rust compiler to 1.66.0
- Conevert bitbake to use argparse
- add -DUSE_X11 Flag to qtbase to work with latest mesa
- Use python3targetconfig in recipes to use right python for target
- Fix waf-samba to use target python3-config
- Fix openCV build with ffmpeg 5.1+
- Update qemu to 7.2.0
- Update cmake to 3.25.1
- Use rm from HOSTTOOLS in rm_work explicitly
- Update wireplumber to 0.4.13 and use dbus defaults
- Update XFCE recipes to 4.18.0 release
- Update python to 3.11.1
- Add rust to SDK toolchain language selection
- Update systemd to 252.4
- Fix several recipes to work with LFS64 functions removal from musl
- Update several gnome recipes to latest
- Update go compiler to 1.19.4
- Fix rust recipes to work with musl without LFS64 functions

### Added

- New recipes - xdg-desktop-portal-wlr, basu, gnome-software,
  xdg-desktop-portal, editorconfig, python3-rapidjson, tuna, sip,
  python3-uefi-firmware, python3-linux-procfs, python3-schedutils, gcr-4,
  python3-watchdogdev, appstream, libtraceevent, libtracefs, flatpak,
  flatpak-xdg-utils, libslirp
- Add time64.conf to enable 64bit time_t on 32bit glibc systems
- Add x86-64-v3 tunes (AVX, AVX2, BMI1, BMI2, F16C, FMA, LZCNT, MOVBE, XSAVE)

### Removed

- Drop OEBasic siggen from sstate signature
- Remove RRECOMMENDS to rng-tools for sshd package
- Remove SERIAL_CONSOLE variable

## [2022.11] - 2022-11-30

### Changed

- Upgrade clang to 15.0.4
- Upgrade Nodejs to 16.18.1
- Fix libpcre dependent packages build e.g. ettercap
- Upgrade various python package versions
- Add opengl to REQUIRED_DISTRO_FEATURES for various packages
- Fix several packages build with python 11
- Enable ipv6 support in nginx
- Add build support to build golang compiler on ppc64le
- Add savedefconfig task in u-boot
- Upgrade openssl to 3.0.7
- Upgrade rust to 1.65.0
- Upgrade weston to 11.0.0
- Add libsoup-3.0 dependency to webkitgtk
- Upgrade systemd to 251.8
- Fix uboot on ae350-ax45mp
- Enable glvnd support in mesa
- Add selinux PACKAGECONFIG to several recipes in core

### Added

- Added recipes - gtk-vnc, libglvnd, python3-brotli, minio jwt-cpp, spice-gtk,
  python3-kmod, python3-aioserial
- Add libc testsuite for musl
- Add 7-Zip support in conversion types for image_types
- Add crate in own-mirrors

### Removed

- Removed recipes - sip3

## [2022.10] - 2022-10-30

### Changed

- Bump LAYERSERIES_COMPAT to langdate ( yocto 4.1 )
- Enforce using libgcc for fmt package for float128 support
- Allow creating src-pkgs when using clang compiler globally
- Update clang to 15.0.2 release tag
- linux-starfive-dev bumped to 6.0.0
- Tweak libcamera to build for Raspberry Pi
- Build u-boot-starfive outside source tree
- Improve manuals with reference to familiar tasks
- Assorted package version upgrades
- Update clang to 15.0.3
- Fix bpftrace on RISCV64
- Fix linux-hardkernel 4.9 with GCC 12
- Update documentation for oe-core

### Added

- Add ptest support for bpftrace
- Add new recipe - rpi-libcamera-apps, python3-pytest-json-report Perfetto, md4c

### Removed

- Removed recipes: onboard
- Remove -ffile-compilation-dir from global clang options

## [2022.09] - 2022-09-30

### Changed

- Move clang-native.bbclass to classes/ folder to unbreak other layers
- Fix function used in AC_CHECK_LIB multiple recipes, do not use 'main'
- Fix type mismatches in multiple packages found with clang-15
- Add missing headers for function prototypes in many packages
- Fix buildpaths issues in several more recipes
- Pass -D_GNU_SOURCE to packages needing gnu extentions on musl
- Always set CC and LD for the kernel build
- Fix i686 toolchain relocation issues in gcc-multilib-config
- Fix npm to use https rather than http fetcher
- Fix rust crossbeam-utils for arches without atomics
- Update rust to 1.63.0 and fix build on musl
- Rework llvm handling in mesa
- Add llvm-config wrapper to improve flags handling
- Fix many recipes to build with clang-15
- Define wayland packageconfig for opengl-es-cts,vulkan-cts
- Major version upgrade for assorted recipes
- Upgrade bpftrace to 0.16.0
- Add rpidistro VLC and ffmpeg build
- Update K & R stype functions in autoconf
- Avoid bad checksum race issues in wget fetcher
- Add no-dns-fallback packageconfig to systemd
- Upgrade major version of clang compiler from 14.0.6 to 15.0.0
- Use gcc to build openssh and webkitgtk for now
- Move python3-lxml from meta-python -> core
- Update raspberrypi-firmware to 20220830 snapshot
- Fix target rust with LLVM runtime
- Do not package gprofng.rc in binutils-cross-canadian
- Address sox intermittent build issue
- Fix wireless on Raspberry Pi 4
- Prefer += instead of :append operator in several recipes in core
- Fix weston and gstreamer-plugins-base imx recipes to build with clang
- Fix llvm-objdump crash seen on aarch64/musl golang compiler
- Fix xserver builds on IMX8
- Limit rpidistro-vlc,rpidistro-ffmpeg to rpi machines only
- Fix bunch of CVEs, refer to commits for details
- Update mozjs-91 91.13.0 and fix build with python 3.11
- Update clang to latest on 15.x release
- Fix buildpaths warning on more recipes e.g. exiv2, fltk
- Ubreak opensbi dependencies being added to u-boot for non-riscv machines
- Enable ZSTD as default compression backend for opkg for yoe
- Enable clang for more applications which were marked non clangable Notable
  recipes e.g. u-boot, python3
- Update simpleIOT to 0.5.0 release
- Fix compiler-rt-sanitizers builds on non-x86 builds
- Fix Yoe graphical images with musl to work on IMX8 devices
- Fixes for logger debug() calls
- Fix gcompat on aarch64
- Upgrade mesa to 22.2.0
- Mark simpleIOT builds on riscv32 incompatible since golang support does not
  exist yet
- Fix recipes in meta-arm to build with clang-15
- Update clang to 15.0.2
- Logic in gtk-icon-cache class fixed for GTK4
- Update tzdata to 2022d
- Update rpm to 4.18.0-release
- Fix weston imx version packageconfig appending syntax error

### Added

- New recipes
  - libconfig-tiny-perl
- Add layer setup tool in OE-Core
- Add documentation for numa machine feature
- Add support for a ARMv8 machine supporting multiple Raspberry Pi boards
- Add yoe-ptest-image target for ptests
- Add enable_loopback_networking() function in bitbake utilities

### Removed

- Remove ypbind-mt on musl
- Remove unifex recipe
- Drop capstone support in ruby
- Remove mozjs-78 recipe
- Drop sqlite2 recipe

## [2022.08] - 2022-08-31

### Changed

- Switch to poky for providing core layer and bitbake
- Fix fluentbit builds on 32bit machines without 64bit atomics
- Upgrade binutils to 2.39 release
- Clean sourced from workspace after devtool finish
- Update python3-setuptools to 65.x
- Add support for config snippet includes to ssh and sshd
- Address recipes with -Wimplicit-function-declaration as error in
  pedantic-errors with clang 15
- Update optee to 3.18
- Update musl to tip of trunk
- Fix klibc with 5.19 kernel headers
- Fix RWX permission error in optee
- Update pipewire to v0.3.56
- Update u-boot and kernel recipe for starfive
- Upgrade gcc to 12.2.0
- Updated linux-yocto to v5.15.68, v5.19.9
- Fix rng-tools to drop wrong dependencies which delayed boot
- Fix several recipes for musl builds missing -D_GNU_SOURCE
- Several fixes for clang-15 found errors
- Enable SDL backend for host QEMU to allow UI option along with vnc
- Disable O2 in systemd when using clang for now
- Do not use llvm-strip system-wide for now due to bugs
- Enable installing libc++.so as linker script
- Fix libgcrypt ptests and install
- Update glibc to have mount.h conflicts solved on 2.36 release branch
- Fix several recipes to compile with clang-15 on musl

### Added

- Add recipe for mdio-tools, usbmuxd, libusbmuxd, libimobiledevice, libplist,
  gst-editing-services, uutils-coreutils, python3-asgiref
- Added clang-native class to build native compoennts with clang
- Add test for debuginfod
- Add devmem 128-bit support in busybox
- Add tune-neoversen2 based on armv9a

### Removed

- Drop has-elf-tls option from rust-target-config

## [2022.07] - 2022-08-19

### Changed

- Update clang to 14.0.6
- Fix compiler-rt build for ARMv5
- Fix native and nativesdk builds for armhf targets
- Fix absolute interpreter paths in php, libdbi-perl, libparse-yapp-perl
  libdev-checklib-perl
- Update mariadb to 10.8.3
- Update qtwebengine to v5.15.10-lts and use chromium-87
- Update reference kernels linux-yocto/v5.10.134 v5.15.59
- Add recipe for linux-yocto 5.19
- Update gstreamer to 1.20.3
- Add selftest for shebang overflow
- Upgrade openssl to 3.0.4
- Fix multiple recipes for too long shebang
- Filter build paths on statically linked go arches
- Fix reproducibility issues in perf, gperf
- Fix recipes to build with kernel 5.19+
- Update wayland to 1.21.0
- Upgrade rust to 1.62.0
- Add ptests for curl
- Switch glmark2 build system to use meson
- Distribute sample-config-files with openvpn
- Remove logs from ltp installs, disable -mfpmath=sse on x86
- Fix kernel source handling when not using externalsrc
- Use the python3 ThreadPoolExecutor instead of the OE ThreadedPool
- Fix missing MLPREFIX in debug mappings in gcc runtime
- Use picobuild in python_pep517 class
- Backport a fix for gcc bug 105039
- Upgrade glibc to latest 2.35 branch and binutils to 2.38 branch tip
- Add PACKAGECONFIG for capstone in ruby recipe
- Fix gcc-runtime build when using gold linker
- Fix bunch of recipes to remove buildpath QA warnings
- Upgrade python3-picobuild to 0.2 fixes build of some of the
  python_setuptools_build_meta inheriting recipes
- Add many unrelated/patched CVEs to ignore list in meta-oe
- Disable cache for g-ir-scanner in gobject-introspection-data class
- Fix newlib and baremetal toolchain builds when using gcc-12
- Update go to 1.19
- Update u-boot to 2022.07
- Update meson to 0.63.0
- Fix rust SDK generation
- Fix sanitizers build with glibc 2.36
- Fix several recipes for mount.h conflict in glibc 2.36
- Fix supplier field in create-spdx
- Use tools from cross-binutils in wic operations
- Fix LTP build with ld-is-gold in DISTRO_FEATURES
- Rework rust recipes to facilitate nativesdk builds
- Fix glibc builds with DEBUG_BUILD turned on
- Override LIC_FILES_CHKSUM for starfive_v2021.04 u-boot
- Update linux-raspberrypi to 5.15.56
- Backport patch to fix CYW43455 and various CVEs for bluez-firmware-rpidistro
- Fix the buildpaths issue in several recipes
- Fix insufficent entropy in sigtask file names
- Fix many packages for configure tests failing with clang-15
- Add fixes for packages to build with glibc 2.36
- Address linux 5.19 fails in multiple recipes
- Add memory pressure regulation in runqemu
- Update OPTEE to 3.18
- Specify -ffile-compilation-dir to omit absolute file paths in debug info
- Remove-libtool inherits from recipe namespace
- Update rust to 3.62.1
- Upgrade glibc to 2.36
- Resolve relative prefix-map filenames and symlinks in GCC
- Prepare several recipes to build with upcoming clang-15
- Switch debug source handling to use prefix map

### Added

- Added recipes: libspiro, python3-picobuild, python3-oslash
  python3-jsonrpcclient, python3-aiodns, python3-pycares waylandpp,
  python-requests-unixsocket, sshpass
- Add support for visionfive board in meta-riscv
- Add QA check for shebangs
- Add buildpaths to WARN_QA by default
- Introduce UBOOT_MKIMAGE_KERNEL_TYPE
- Add cpu/io pressure regulation to bitbake runqueue
- Implement recipe and global classes in bitbake
- add Andeas RISCV ae350-ax45mp machine support

### Removed

- Remove obsolete PEP517_BUILD_API
- Remove the ThreadedPool implementation in oe/utils
- Remove recipe for xf86-input-keyboard
- Remove historical movement of libz.so to /lib
- Remove CMAKE_ASM_FLAGS variable in toolchain file
- Drop v5.10 reference linux-yocto kernel recipes
- Remove largefile distro feature

## [2022.06] - 2022-07-04

### Changed

- Bump bitbake to 2.0.1
- Build clang_rt.profile compiler-rt library when possible
- Use nftables instead of iptables by default in networkmanager
- Bump riscv linux-mainline to 5.18
- Update perl to 5.36.0
- Update systemd to 251.2
- Add zstd dependencies in gcc recipes
- Set RebootWatchdogSec to 60s as watchdog in systemd
- Major version upgrades for multiple recipes
- Compile ptests with parallelism, disable packages where it fails
- Fix networkmanager build when ppp is enabled
- Upgrade PHP to 8.1.7
- Switch polkit back to mozjs from duktape
- Upgrade strace to 5.18
- Upgrade alsa recipes to 1.2.7.1
- Upgrade major versions of assorted recipes
- Upgrade go to 1.18.3
- Upgrade mesa to 22.1.2
- Fix udev-extraconf lvm automount
- Upgrade python to 3.10.5
- Add support for Ignored CVEs in cve-check
- Enable xwayland in weston init
- Enable gnu-efi for riscv64
- Add SDK support to image-buildinfo
- Fix systemd to build without utmp support
- Upgrade linux-yocto to v5.10.119, v5.15.44
- Enable MDIO bus config in linux-yocto

### Added

- Added recipes libavtp, libtomcrypt, flite
- Add QB_KERNEL_CMDLINE to runqemu

### Removed

## [2022.05] - 2022-05-31

### Changed

- Update meta-ti recipes to SDK 08.02.00.005
- Let the user drive the update interval for CVE database
- Correctly handle file names containing colons in bitbake
- Fix firmware autoloading for rpi by creating
  brcmfmac43455-sdio.raspberrypi,4-model-b.bin symlink
- Update qemu to 7.0.0 = Upgrade musl to tip of trunk
- Upgrade 250.5
- Use arm-versatile-926ejs KMACHINE for qemuarmv5
- Make git intercept global
- Upgrade GCC to 12.1
- Add openssh-sftp-server to openssh RDEPENDS
- Upgrade linux-firmware to 20220509
- Upgrade linux-raspberrypi to 5.15.38
- Various native recipes fixed to bulld with GCC 12
- Upgrade GDB to 12.1
- Build bash to use proper getcwd() on musl
- Fixes for meta-qt5/meta-intel build failures seen with GCC-12
- Enable using private fonts in wxwidgets
- Fix rare sysroot corruption issue during staging
- Add fspassno parameter to partition in wic
- Fix osc fetcher to support quering latest revision
- Update clang to 14.0.4
- Update mariadb to 10.7.4
- Move lzop from core to meta-oe
- Upgrade QT5 to latest 5.15.4 and fix with musl
- Disable lzo support by default in various recipes
- Fix native builds to use right linker paths in go bbclass
- Update linux-yocto to v5.10.114, v5.15.38
- Upgrade gstreamer to 1.20.2
- Upgrade go to 1.18.2
- Upgrade setuptools to 62.3.1
- Upgrade curl to 7.83.1
- Various recipe version bumps

### Added

- Enable updater support for raspberrypi2 machine
- `meta-raspberrypi` now supports enabling 1-wire bus on GPIO4 with
  `ENABLE_W1 = "1"` in `local.conf`
- Add meta-python to meta=gnome layer dependencies
- Add support for building python recipes which use hatchling
- Add recipe for cpulimit, openzfs, ulog2, libcoap, btrfsmaintenance
  python3-web3, python3-lru-dict, python3-eth-account, python3-eth-abi
  python3-parsimonious, python3-eth-rlp, python3-rlp, python3-hexbytes
  python3-eth-keyfile, python3-eth-keys, python3-eth-utils python3-eth-typing,
  python3-eth-hash, python3-decouple python3-cytoolz, python3-toolz,
  python3-inotify, nodejs-oe-cache-native overlayfs-progs, overlayfs-tools,
  python3-uinput, xfstests python3-editables, python3-hatchling,
  python3-pathspec python3-setuptools-scm-git-archive

### Removed

- Remove meta-networking dependency on meta-python by re-arranging recipe
  locations
- Drop GPL-3.0 license from libgcrypt
- Remove uclibc remnants from DISTRO_FEATURES
- Removed recipes: speedtest-cli
- Remove libsrvg rv32 patch

## [2022.04] - 2022-05-01

### Changed

- Use clang for python3 compilation and many other recipes
- Use internal version fo ffmpeg for omxplayer
- Update linux-rapberrypi to 5.15.34
- Add ability to specify CPUs to add to the isolcpus list for rpi-cmdline
- Upgrade uninative to 3.6 with gcc 12 support
- Upgrade linux-yocto/5.15 to v5.15.36, linux-yocto/5.10 to v5.10.112
- Fix gcc thread sanitizer against glibc 2.34
- Update python3 to 3.10.4
- Update tzdata to 2022a
- Fix specific version handling for ipk and deb package types
- Upgrade gtk4 to 4.6.2
- Various python module recipe upgrades
- Gnome and XFCE recipe upgrades
- Enable usrmerge feature distro wide
- Switch default docker build to use bullseye/debian-11
- Enable overlayfs to mount r/w parition on rootfs
- Bump simpleiot to 0.0.45
- Enable persistent logs across reboots
- Build own bmaptool-native and remove depending on build host for it
- Assorted recipe major version upgrade
- Allow auto detection of the correct graphics options in runqemu
- Use https with github for SRC_URIs in meta-riscv
- Fix several recipes to compile with GCC-12
- Upgrade Go compiler to 1.18
- Upgrade OpenSSH to 9.0p1
- Fix nativsdk builds for LLVM runtime
- Fix several recipes to buils on ppc/ppc64 with clang
- Fix several recipes to build properly with usrmerge distro feature
- Upgrade GCC to 11.3 release
- Fix several recipes to build with out X11
- Upgrade glibc to latest bugfixes on 2.35 release
- Upgrade rust compiler to 1.60
- Upgrade Clang to 14.0.3
- Enable xz compression in kmod
- Switch linux-raspberrypi to have compressed kernel modules

### Added

- Add recipes for OpenThread
- Add recipes for idevicerestore, libadwaita, frr
- Add support for nezha-allwinner-d1 machine
- Add os-release-initrd package
- add UBOOT_ENTRYPOINT to match LOADADDR in linux-raspberrypi
- Add MCP3008 ADC overlay for RPI machines
- Add tune include for armv8.4a
- Add tunes for rv64 without compressed instructions
- Introduce git intercept script due to fakeroot issues in devshell
- Add recipe for musl-locales

### Removed

- Drop meta-96boards layer, its unused
- Remove recipes for rpi-hwup-image and rpi-basic-image
- Drop GOBUILDMODE
- Remove invalid GLIBC_EXTRA_OECONF for ppc32

## [2022.03] - 2022-03-30

### Changed

- Update clang to 14.0.0
- Fix multilib support in clang based toolchain
- Improve llvm-config detection logic in cross builds
- Enable llvm runtime for ppc32
- Disable altivec intructions when using clang on qemuppc
- Fix python module recipes to support PEP-517 packaging
- Update nodejs to 16.14.0 LTS
- Fix gyp to work with python 3.10+
- Upgrade linux-raspberrypi 5.15 to 5.15.30
- Bump riscv linux-mainline to 5.17
- Update linux-yocto to v5.10.107, v5.15.30
- Update SRC_URIs for brcm firmware in meta-riscv
- Show warning for obsolete license usage
- Improve deterministic builds for perl, quilt, and cups
- Upgrade SQlite3 to 3.38.0
- Replace non-SPDX license identifiers in OE-core
- Use SPDX license identifiers in recipetool
- Enable networking in all icecc tasks
- Rework INCOMPATIBLE_LICENSE wildcard and variable handling
- Improve ssh fetcher to support path handling
- Use SPDX license identifiers in all meta-openembedded layers and meta-intel
- Fix recipes in meta-openembedded needing legacy setuptools support
- Reduce default dependencies for native sysroot, drop libarchive and util-linux
- Drop opt-1 and opt-2 pyc files in native python to reduce number of files
- Fix build race in binutils/assembler docs
- Improve eSDK layer path assumptions to support more layouts
- Enable systemtap for RISCV64
- Use SPDX license naming convention in meta-clang, meta-odroid, meta-riscv
- Enable riscv64 builds for bcc,libbpf
- Remove depenendency for virtual/libgl where possible, use virtual/egl
- Fix recipes to build without X11 in distro features
- Improve PYPA_WHEEL detection for wheel packaging and cleanup pip_install_wheel
- Upgrade go to 1.17.8
- Upgrade rust to 1.59.0
- Update cmake to 3.22.3
- Add AGPL-3.0 wildcard to expand_wildcard_licenses
- Upgrade QT5 to v5.15.3-lts-lgpl
- Improve pip_install_wheel to not need PIP_INSTALL_DIST_PATH and PYPA_WHEEL
- Bitbake fixes for toaster support
- Fix several recipes for ppc64 builds
- Upgrade gstreamer to 1.20.1
- Fix global ppc/ppc64 sitefiles for musl and glibc differences
- Bump bitbake to 2.0.0
- Fix more recipes to use branch and protocol parameters in github SRC_URI
- Move petry python packaging infrastructure from meta-python to core layer
- Fix qemuppc64 recipes and booting with 5.15 kernel
- Adjust recipes for renaming flit_core -> python_flit_core
- Fix rust packages to build for riscv32 and musl
- Update systemd to 250.4
- Fix several recipes to build when LIBDIR != lib by default, fixes ppc64
- Convert virtual/libgl to virtual/egl dependencies where possible
- Upgrade libtool to 2.4.7, needed few recipes to re-generate macros
- Update musl to latest master
- Fix rust toolchain for SDK environment
- Fix weston 10.x build for TI socs using sgx driver
- Add GLES3/GL headers to SGX DDK

### Added

- Add poetry_core helper class for supporting poetry for python packages
- Add snapshot checksums for powerpc64le hosts
- Add support to build on FIPS enabled build hosts
- Added setuptools3_legacy bbclass to keep pre PEP-517 behavior
- Add nativesdk support to cargo and rust compiler tools
- Add Dockerfile in bitbake repo for building PR service
- Add MOUNT_COPYBIND_AVOID_OVERLAYFS env var to skip OverlayFS
- New recipes
  - hstr, python3-qface, python3-path, python3-antlr4-runtime
  - python3-crc32c, gosu,

### Removed

- Drop AVAILABLE_LICENSES variable
- Remove the available_licenses() function from license.bbclass

## [2022.02] - 2022-02-28

### Changed

- Upgrade simpleiot to 0.0.42
- Enable network during compile/configure step of simpleiot
- Build kernel with initramfs for sifive/unmatched
- Use renamed terms for variables for inclusive language changes
  - BB_ENV_PASSTHROUGH_ADDITIONS
  - LICENSE_FLAGS_ACCEPTED
  - SKIP_RECIPE
  - CVE_CHECK_IGNORE
  - LICENSE_EXCLUSION
- Use yocto URL for testing CONNECTIVITY_CHECK_URIS
- Switch to kirkstone ( yocto 3.5 ) codename across layers
- Only allow network access in do_fetch tasks
- Cleanup use of distutils in oe-core, replace with setuptools
- linux-yocto updated to v5.10.99, v5.15.22
- Update busybox to 1.35 release
- Enable threading in perl
- Update various gnome recipes to 41.1 release
- Upgrade strace to 5.16
- Switch raspberrypi4-64 to cortexa72 tune
- Upgrade ffmpeg to 5.0
- Upgrade meson to 0.61.1 and fix packages to build with this version
- Update PHP to 8.1.3
- Upgrade gstreamer to 1.20.0
- Use arm BSPs to use linux-yocto 5.15
- Update clang to 14.0.0-rc1
- Use LLVM binutils by default e.g. nm, strip, objcopy, objdump etc.
- Set precise BSD license in various recipes
- Upgrade glibc to 2.35
- Upgrade binutils to 2.38 release
- Upgrade gdb to 11.2
- Upgrade go to 1.17.7
- Upgrade musl to tip of master/f8bdc3048216f41eaaf655524fa286cfb1184a70
- Upgrade weston to 10.0.0
- Disable sse4.1 and sse4.2 in openCV on x86
- Upgrade linux-firmware to 20220209
- Bump bitbake version to 1.53.1
- Use 5.15 as default kernel for RPI machines
- Add support for gtkmm4
- Disable optimizations for libvorbis,x264,dcadec,graphviz on mips to avoid
  clang bug
- Migrate many python recipes to use wheels packaging format
- Upgrade ruby to 3.1.1
- Move distutils bbclasses to meta-python

### Added

- Add example to generate username/password in image and local.conf
- Add recipe for python3-gammu, duktape, python3-picamera, seatd
  googlebenchmark, python3-pytest-xdist, python3-pytest-xdist python3-pytest-qt
- Introduce cortexa73-crypto tune
- Add the support for the Neoverse N2 core
- Add tune include for armv8.5a
- Add setuptoools Rust plugin
- Add class for PyO3 cross-compilation
- Add crate fetcher in bitbake
- Add recipe for 5.15 LTS linux-raspberrypi kernel

### Removed

- Prelinker support
- Drop the redundant cortexa72-crc tune
- Remove recipes for mailx, libjs-jquery, python3-anyjson, python3-nose
- Remove libsegfault and catchsegv
- Remove bogus CMAKE_LDFLAGS_FLAGS definition from cmake toolchain file

## [2021.12] - 2021-12-17

### Changed

- Fix qtwayland vulkan build on GLES2
- Upgrade libcamera to latest
- Add new recipe for 2.6 version trusted-firmware-a
- Use GCC runtime on ppc32 and armv5 when using clang compiler
- Support building clang based compilers on OE build hosts
- Upgrade RPI kernel (linux-raspberrypi) to 5.10.83
- Upgrade WebKit to 2.34.2
- Upgrade linux-yocto - linux-yocto/5.15 - v5.15.10 linux-yocto/5.10 - v5.10.87
  linux-yocto/5.14 - v5.14.21
- Upgrade mesa to 21.3.1 and fix build for RPI0W and vulkan
- Upgrade Go to 1.17.5
- Upgrade rust to 1.57.0
- Upgrade opkg to 0.5.0
- Remove crypto for the default cortex-a72 tune
- Add redirectauth parameter to wget fetcher
- Ensure dumpsig output is deterministic in siggen
- Improve lockfile handling race in bitbake runqueue
- Update clang to 13.0.1 RC1
- Use 5.15 kernel for linux-ti-mainline
- Improve lttng-tools ptests determinism
- Let mesa provide virtual/libgles3
- Fix kmscube build on OpenGL ES 3
- Update and enhance netdata 1.32.1
- Update php to 8.1
- Update openSSL to 3.0.1
- Fix oe-stylize script to address new override syntax
- Update QEMU to 6.2 and add selinux PACKAGECONFIG
- drop OLDEST_KERNEL reference in qemu-usermode
- Cleanup tzdata recipe
- Add Inactive-Upstream to Upstream-Status
- Update clang to latest 13.x branch
- Assorted recipe upgrades

### Added

- Added recipes
  - gutenprint, usbip-tools, pycups

### Removed

- Removed recipes
  - rustfmt

## [2021.11] - 2021-12-01

- Use https protocol in github SRC_URI
- Use branch setting in git uris explicitly
- Update clang to latest on 13.x release branch
- Fix recipes to not install /var/log /var/run during build time but create them
  at runtime
- Fix mdns on musl
- Fix Gnome recipes in meta-gnome
- Update musl to tip of trunk which has qsort_r now
- Add a new build QA check to check for empty folders
- Fix recipes e.g. mctp, sdbus to compile against 5.15 kernel headers
- Update gdb to 11.1
- Show warnings for append/prepend/remove operators combined with +=/.=
- Specify protoc explicitly when building protobuf-c, helps cross compile
- Use https protocols for github SRC_URIs in meta-raspberrypi
- Introduce Linux 5.15 based linux-libc-headers
- Fix recipes to work with 5.15 headers e.g. ppp
- Update linux-yocto v5.10.79, v5.15.2, v5.14.18
- Drop using lnr in favor of ln -rs in recipes
- Fix wic image generation by reverting to using os.rename
- Add uninative mirror on kernel.org
- Build target qemu on musl targets as well
- improve SDK's wrapper to make Wraps work in meson
- Use wayland distro feature for native builds
- Fix task-depends.dot for multiconfig targets
- Adjust recipes using meson to work with meson 0.60+
- Upgrade linux-raspberrypi to 5.10.81
- Fix parselogs regular expressions for 5.10 kernel
- Add Pi Zero 2 Wifi 64bit yocto machine in meta-raspberrypi
- Upgrade php to 8.x
- Upgrade linux-staging-ti to 5.10.65
- Drop compatibility mappings and dbus dependency in core packagegroups
- Support read-only rootfs in QEMU machines
- Refresh PREMIRRORS/MIRRORS settings in metadata, some of them were stale
- Update rust to 1.56.1
- Update patch status, many of them are submitted upstream
- Use https:// instead of git:// for github.com SRC_URIs in meta-qt5
- Fix github SRC_URIs to have explicit branch names
- Use usermode qemu to run minilua during php8 build
- Change the default cipher to AES-256-GCM for openvpn server configurations
- Fix rust runtime library and librsvg on riscv32/musl
- Add sanity check for allarch packagegroups
- Use bullseye branch for linux-firmware-rpidistro package
- Set precise BSD license for meta-openembedded recipes
- Remove introspection as this is not valid meson 0.60+ option
- Fix missing installation of cups sysv init scripts
- Upgrade and fix freerdp 2.3.0 -> 2.4.1
- Fix mozjs on centos7 build hosts
- Add Wi-Fi/BT drivers for CM4 and Pi 400 to Raspberrypi4 machine configs
- Upgrade mesa to 21.3.0
- Fix OEQA warnings for append operators combined with +=
- Improve rust support in meson based builds
- Upgrade go to 1.16.10
- Support rootdev identified by partition label in wic
- Do not use CET on i586 and c3 tunes
- Switch TI SOCs to use PVR graphics
- Fix PVR drivers to work with 5.10+ kernel
- Add ar wrapper for determinism for native/cross recipes
- Add needed sysroot dependencies for repo fetcher
- Fix launching weston without keyboard and mouse on BBB and RPI
- Update Go to 1.17 release
- Assorted recipe upgrades
- New recipes
  - ntpsec, mozjs-78, gtk4, python3-imgtool, fwupd, fwupd-efi
  - python3-pytz-deprecation-shim, python3-aiosignal, python3-frozenlist
  - python3-charset-normalizer, python3-cchardet, python3-email-validator
  - python3-gcovr

## [2021.10] - 2021-11-01

- Update vc-intrinsics to latest
- Fix gattlib with latest pkgconfig changes and upgrade recipe
- Fix multiple build determinism reproducibility issues in oe-core
- Add Unified Kernel Image option for bootimg-efi wic image
- Drop broken pyc files in python3 package
- rockchip use uuid for /boot during fstab-update in wks file
- Define new libnfs PACKAGECONFIG for QEMU
- Fix cross compilation of grpc
- Enable system instance of pipewire-media-session in pipewire
- Avoid sysroot race issues when multilib is enabled
- Fix no longer valid URLs in oeqa manual
- Replace http with https for URLs in bitbake
- Improve npm fetcher to support archives missing directory mode
- Drop libcidn package from glibc
- Add fcntl64 wrapper to pseudo
- Default to xz compresison for archiver
- Add explicit branch= in recipes in oe-core
- Fix simpleIOT build race and update to 0.0.37
- Add support for big endian 64-bit PowerPC to rust
- Fix librsvg on rv32
- Disable seccomp on systemd/mips32
- disable LLD usage in clang
- Drop libcidn package from glibc
- Update python recipes
- Recipe Updates
  - gpsd - 3.23.1, cmark - 0.30.2, cifs-utils - 6.14
  - phpmyadmin - 5.1.1, intel-graphics-compiler - 1.0.8744
  - strace - 5.14, intel-compute-runtime - 21.37.20939
  - linux-yocto - v5.10.75,v5.14.14
  - linux-raspberrypi - 5.10.76, raspberrypi-firmware - 20211007
  - hiredis - 1.0.2, redis-plus-plus - 1.3.2, atftp - 0.7.5
  - links - 2.25, autofs - 5.1.8, mozjs - 91.2.0, cryptsetup - 2.4.1
  - waffle - 1.7.0, asciidoc - 10.0.0, tzdata - 2021e
  - ncurses - 6.3, vte - 0.66.0, libcap - 2.60, diffoscope - 188
  - wpebackend-fdo - 1.12.0, webkitgtk - 2.34.1, mpg123 - 1.29.2
  - libinput - 1.19.2, gi-docgen - 2021.8, msmtp - 1.8.18
  - python3-setuptools - 58.3.0, createrepo-c - 0.17.7
  - bdwgc - 8.0.6, samba - 4.14.8, intel-mediasdk - 21.3.5
  - intel-media-driver - 21.3.5, libva - 2.13.0, gmmlib - 21.3.1
  - leptonica - 1.82.0, u-boot - 2021.10, lttng-tools - 2.13.1
  - libdnf - 0.65.0, file - 5.41, dnf - 4.10.0, dhcpcd - 9.4.1
  - vboxguestdrivers - 6.1.28, rust - 1.56.0, librsvg - 2.52.2
  - mesa - 21.2.4, gnupg - 2.3.3, libsoup-2.4 - 2.74.0, libmd - 1.0.4
  - libcap - 2.59, libatomic-ops - 7.6.12, iso-codes - 4.7.0
  - fribidi - 1.0.11, libwpe - 1.12.0, mpg123 - 1.29.0
  - wireless-regdb - 2021.08.28, linux-firmware - 20210919
  - libinput - 1.19.1, pango - 1.48.10, harfbuzz - 3.0.0
  - libdazzle - 3.42.0, json-glib - 1.6.6, sudo - 1.9.8p2
  - gsettings-desktop-schemas - 41.0, gobject-introspection - 1.70.0
  - msmtp - 1.8.17, libarchive - 3.5.2, asciidoc - 9.1.1
  - acpica - 20210930, vala - 0.54.2, librepo - 1.14.2
  - libedit - 20210910-3.1, libcomps - 0.1.18, ccache - 4.4.2
  - btrfs-tools - 5.14.2, sysvinit - 3.00, openssh - 8.8p1
  - ofono - 1.33, git - 2.33.1, cmake - 3.21.3, bison - 3.8.2
  - libxcrypt - 4.4.26, libgit2 - 1.3.0, curl - 7.79.1
  - ca-certificates - 20211016, liberation-fonts - 2.1.5
  - libva - 2.13.0, libgit2 - 1.3.0, curl - 7.79.1
  - liberation-fonts - 2.1.5, valgrind - 3.18.1, meson - 0.59.2
  - systemd - 249.5, ovmf - 202108, bluez5 - 5.62
  - lighttpd - 1.4.60, ghostscript - 9.55.0, kea - 2.0.0
  - libjitterentropy - 3.3.0, lua - 5.4.3, rpm - 4.17.0
  - qemu - 6.1.0, gnupg - 2.3.2, pinentry - 1.2.0
  - spirv-tools - 2021.3, glslang - 11.6.0, shaderc - 2021.2
  - inetutils - 2.2, lsof - 4.94.0, libpam - 1.5.2, rt-tests - 2.2
  - libgit2 - 1.2.0, libssh2 - 1.10.0, libhandy - 1.4.0
  - iproute2 - 5.14.0, gzip - 1.11, harfbuzz - 2.9.1
  - vulkan - 1.2.191, help2man - 1.48.5, wayland-protocols - 1.23
  - python3 - 3.10, ethtool - 5.14, xf86-input-libinput - 1.2.0
  - libinput - 1.19.0, acpid - 2.0.33, ell - 0.44, go - 1.16.8
  - libseccomp - 2.5.2, gstreamer1.0 - 1.18.5, busybox - 1.34.1
  - 41.0, openssl - 3.0.0, glib-2.0 - 2.70.0, libexif - 0.6.23
  - wget - 1.21.2, coreutils - 9.0, itstool - 2.0.7
  - epiphany - 41.0, libsolv - 0.7.20, libxi - 1.8
  - libxkbcommon - 1.3.1, xkeyboard-config - 2.34, xorgproto - 2021.5
  - man-pages - 5.13, at-spi2-core - 2.42.0
- New recipes
  - gn, lv-drivers, lvgl, python3-posix-ipc, libxcvt
  - libjs-jquery-globalize, libjs-jquery-cookie
- Removed recipes
  - chipsec

## [2021.09] - 2021-09-30

- Implement data partition resize feature in yoe updater
- Add initial support to generate SBOMs
- Set precise BSD linceses in recipes in OE-Core and meta-openembedded
- Let updater machine files be defined in layers outside meta-yoe
- Fix bpftrace build with clang 13
- Avod task graph corruption when trying to avoid deadlocks in runqueue
- Drop obsolete oe_machinstall function utility
- Update simpleIOT to v0.0.34
- Fix fcntl in pseudo with glibc 2.34
- Add selinux packageconfig for tar,findutils,coreutils
- Allow upstream for local hash equivalence server in bitbake
- Make externalsrc work with reproducible_build
- Ensure XZ_THREADS doesn't change sstate checksums
- Add packageconfig for wheel-group in systemd
- Avoid problems with recipes using SRCPV when fetching sstate
- Enable ftps in wget fetcher
- Add tpm2 packageconfig to systemd
- Prepare bitbake for python 3.10 compatibility
- Enable lima with rock64
- Change one of licenses from expat to MIT in ffmpeg
- Fix qtwayland build with clang
- Fix missing pkgconfig inherit in QT5 recipes
- Use uuid instead of hard-coding root device for rockchip devices
- Remove obsolete intltool-native dependency from recipes
- Add missing pkgconfig inherit in oe-core and meta-openembedded
- Remove useless class from meta class, reduces amount of sstate needed
- Ensure task checksums reflect site files
- Delete dead entries from site files for Orbit2 and libidl
- Delete site file extentions from meta-openembedded layers
- Fix vboxguestdrivers build on kernel 5.14+
- Let user specify target for vk-gl-cts
- Switch linux-yocto defaults to 5.14 kernel
- Use 5.14 as default kernel for odroid
- Allow shutdown/database flush of pseudo server at task exit helps builds using
  containers for build machines
- Fix clang SDK builds when using llvm runtime
- Fix openCV dnn with protobuf-3.18
- Assorted python module updates
- Recipe Updates
  - simpleiot - 0.0.33, go - 1.16.7, unclutter-xfixes - 1.6
  - uhubctl - 2.4.0, nlohmann-json - 3.10.2, monit - 5.29.0
  - libwebsockets - 4.2.2, cjson - 1.7.15, wireshark - 3.4.8
  - gsl - 2.7, xf86-video-nouveau - 1.0.17, ctags - 5.9.20210905
  - avro-c - 1.10.2, ntopng - 5.0, ndpi - 4.0, redis - 6.2.5
  - libjcat - 0.1.8, libeigen - 3.4.0, libbytesize - 2.6, dash - 0.5.11.5
  - crash - 7.3.0, spdlog - 1.9.2, fmt - 8.0.1, msgpack-c - 4.0.0
  - poppler - 21.09.0, poppler-data - 0.4.11, lockfile-progs - 0.1.19
  - libqmi - 1.30.2, dfu-util - 0.11, cppzmq - 4.8.0, mosquitto - 2.0.12
  - fuse3 - 3.10.5, lttng - 2.13.0, linux-yocto/5.10 - 5.10.63
  - linux-yocto/5.13 - 5.13.15, libxmlb - 0.3.2, dnf-plugin-tui - 1.3
  - zchunk - 1.1.16, xterm - 368, unbound - 1.13.2, dnsmasq - 2.86
  - postgresql - 13.4, libbpf - 0.5.0, ndisc6 - 1.0.5
  - clang - 13.0.0-rc3, linux-raspberrypi - 5.10.63, libgcrypt - 1.9.4
  - span-lite - 0.10.1, protobuf - 3.18.0, fio - 3.28, apache2 - 2.4.49
  - nghttp2 - 1.45.1, samba - 4.14.7, gd - 2.3.3, poco - 1.11.0
  - cppzmq - 4.8.1, byacc - 20210808, systemtap - 4.5-latest
  - libc-headers - 5.14, valijson - 0.6, sassc - 3.6.2, sanlock - 3.8.4
  - libsass - 3.6.5, snort - 2.9.18.1, smcroute - 2.5.3
  - unionfs-fuse - 2.2, libqb - 2.0.3
- New recipes
  - python3-pytest-subtests, python3-kivy, pahole, smarty
  - libjs-jquery-icheck, chipsec
- Removed recipes
  - assimp

## [2021.08] - 2021-09-02

- Update to bitbake 1.51.1
- Remove meta-rust layer as rust is in Core now
- Switch to using new override syntax
- Add read-only mode to prserver
- Require python 3.6.0 mininum for bitbake
- Add yocto 3.4 ( honister ) to compatible releases
- Move architecture tune files to arch specific directories
- Upgrade clang to 13.x release
- Make shared library builds of grpc optional
- Drop all custom patches from c-ares and update to 1.17.2
- Delete bootchart recipe
- Link mpich with static libgcc
- Use GNUInstallDirs in cereal and boost-url
- Rename takao-fonts to match other ttf font recipe naming conventions
- Remove unneeded dependency on takao-fonts in uim
- Add flags to enable adbd services in android-tools
- Add selinux as packageconfig knob in networkmanager and augeas
- Add ptest support for jemalloc
- Move opus-tools to meta-multimedia and upgrade to 0.2
- Update SRC_URI for bigbuckbunny-1080p
- Add missing runtime dependencies for mycroft
- Fix image_types_sparse corruption
- Fix fvwm interpreter runtime paths in python/perl script during build
- Drop uclibc remnants from recipes e.g. lua
- Disable building apitrace/libhugetlbfs with glibc 2.34, need porting
- Fix evtest output timestamps
- Fix multiple recipes to build with glibc 2.34 e.g. ntp, autofs, fuse etc.
- Fix qtwebengine build with glibc 2.34
- Add compatibility for non-systemd builds of pi-bluetooth
- Remove connection caching in PR Service
- add tune support for all Arm Cortex-M processors
- Fix SDK relocation symlink
- Use different keys to sign kernel-fitimage and configuration
- Package extlinux.conf separately in u-boot
- Enable RISCV32 for baremetal-helloworld
- Fix reproducibility issues with LTO
- cve-check update link to NVD website for CVE details
- Use BFD linker in systemd-boot ( gold segfaults )
- Upgrade glibc to 2.34 and fix metadata and recipes to build with it
- More granular packaging for gpsd docs
- Extend libkcapi to build natively as well
- Use vc4-kms-v3d device-tree on rpi4 machines to boot into graphics
- Drop target flex/bison from build dependencies in binutils
- Fix pseudo to work with glibc 2.34 systems
- Move odroid kernel to use linux-yocto 5.13
- Fix metacity for out of tree builds
- Migrate odroid-c4 to mainline kernel
- Re-enable apitrace recipe for glibc >= 2.34
- Update BSD licenses to be specific in recipes e.g. BSD -> BSD-3-Clause
- Add RDP packageconfig to weston
- Stop using ext2simg in image_types_sparse
- Stop using "virtual/" in RPROVIDES and RDEPENDS
- Assorted list of python module version updates
- Recipe Upgrades
  - mariadb - 10.6.4, libencode-perl - 3.12, sedutil - 1.15.1.01
  - opensc - 0.22.0, live555 - 20210809, libqmi - 1.30.0, vsftpd - 3.0.5
  - ctags - 5.9.20210815.0, netplan - 0.103, icewm - 2.7.0, udisks2 - 2.9.3
  - networkmanager - 1.32.10, network-manager-applet - 1.24.0
  - fltk - 1.3.7, gpsd - 3.23, fetchmail - 6.4.21, catch2 - 2.13.7
  - audit - 3.0.5, iwd - 1.16, vorbis-tools - 1.4.2, thrift - 0.14.2
  - xwd - 1.0.8, valijson - 0.5, poppler - 21.08.0, monit - 5.28.1
  - libqmi - 1.28.8, libblockdev - 2.26, apache - 2.4.48, mongodb - 4.4.7
  - raspberrypi-tools, raspberrypi-firmware, userland
  - linux-raspberrypi - 5.10.59, rust - 1.54.0, rng-tools - 6.14
  - re2c - 2.2, enchant - 2.3.1, diffoscope - 181, boost - 1.77.0
  - webkitgtk - 2.32.3, libwebp - 1.2.1, wireless-regdb - 2021.07.14
  - linux-firmware - 20210818, xserver-xorg - 1.20.13, libxft - 2.3.4
  - libxfont2 - 2.0.5, libinput - 1.18.1, mesa - 21.2.1, pango - 1.48.9
  - libepoxy - 1.5.9, libjpeg-turbo - 2.1.1, libgudev - 237, epiphany - 40,3
  - sudo - 1.9.7p2, stress-ng - 0.13.00, libidn2 - 2.3.2, acpica - 20210730
  - squashfs-tools - 4.5, pkgconf - 1.8.0, patchelf - 0.13, mtools - 4.0.35
  - log4cplus - 2.0.7, libedit - 20210714-3.1, help2man - 1.48.4
  - e2fsprogs - 1.46.4, linux-yocto - v5.13.12, linux-yocto/5.10 - v5.10.60
  - libconvert-asn1-perl - 0.31, ell - 0.43, strace - 5.13, cmake - 3.21.1
  - util-linux - 2.37.1, iputils - 20210722, shadow - 4.9, bind - 9.16.19
  - i2c-tools - 4.3, gcc - 11.2, curl - 7.78.0, libio-socket-ssl-perl - 2.072
  - linuxptp - 3.1.1, harfbuzz - 2.9.0, bind - 9.16.20, json-glib - 1.6.4
  - gi-docgen - 2021.7, libnsl2 - 2.0.0, vala - 0.52.5, openssh - 8.7p1
  - git - 2.33.0, ccache - 4.4, util-linux - 2.37.2, glib-2.0 - 2.68.4
  - gnu-efi - 3.0.14, openssl - 1.1.1l, bluez - 5.61, libbpf - 0.4.0
  - xmlsec1 - 1.2.32, sedutil - 1.20.0, live555 - 20210824, iwd - 1.17
  - gensio - 2.2.9, doxygen - 1.9.2, can-utils - 2021.08.0
  - xfsprogs - 5.13.0, busybox - 1.34.0, rdma-core - 36.0
  - xf86-input-tslib - 1.1.1, pipewire - 0.3.34, nftables - 1.0.0
  - uninative - 3.4
- New recipes
  - bmon, libconfuse, ttf-ipa, jemalloc, python3-pkcs11
  - python3-cached-property, bluealsa
- Removed recipes
  - libnss-nisplus

## [2021.07] - 2021-07-30

- Check for wayland distro feature before enabling egl in qtwayland
- Introduce armv8r64 compiler flags in arch-armv8r64
- Fix openssh key generation
- Fix pulseaudio build on non-neon ARM CPUs
- Add error diagnostics for generating multiconfig eSDKs
- Upgrde python3 to 3.9.6
- Fix race condition in building bash
- Fix race in sstate/staging directory creation
- Fix multilib enabled clang builds
- Use GNUInstallDirs in portaudio-v19 to fix ppc64 builds
- Disable JIT in sysdig for ppc64
- Fix vboxguestdrivers build with kernel 5.13
- Fix samba dependency on pidl
- Fix bats when multilib is enabled
- Fix testsuites for util-linux
- Allow controlling zoneinfo binary format in tzdata
- Fix test races in multiprocesslauch and dwarfsrcfiles
- Add ARC support to dhcpcd
- Assorted python package/recipe version upgrades
- Run git fetcher garbage collector in foreground to avoid race with tar
- Update u-boot to 2021.07 in meta-arm
- Fix checksums in ARM toolchain recipes
- Fix native recipes to use libcxx+compiler-rt runtime when using clang
- Assorted recipe updates in meta-perl and meta-python
- Fix sysbench memory test
- Fix ltrace build on mips with kernel 5.13+
- Fix systemd service start failure
- Use qemu to run cross-compiled binaries during build
- Fix gimp build race and qemu segfaults by disabling pango on native builds
- Update raspberrypi firmware to 20210527
- Ramp up tcl recipe and fix several build time issues e.g. races
- Do not exclude pseudo from sstate and update to latest
- Update update-rc.d to get support for non-bash shells
- Disable chfn-chsh on non-target builds in util-linux
- Drop pulseaudio-conf
- Add workaround to fix hang on boost-build-native
- Fix build failures in glibc-testsuite
- Drop adding RRECOMMENDS for license packages
- Upgrade and port libseccomp for RISCV32
- Fix install race in python3
- Fix signature of close_range() in util-linux
- Add support for s3:// scheme in SOURCE_MIRROR_URL
- Support mounting swap via labels in busybox
- Fix early parsing errors preventing zombie bitbake
- Build native versions of libcxx and compiler-rt
- Fix build issues with freedom-u540 BSP support
- Add systemd unit for netperf
- Add convert-overrides.py script for new overrride syntax conversion
- Include pzstd in zstd build
- Add MAINTAINERS.md file
- Fix glew Makefile race
- Set UBOOT_MACHINE for mips/mips64 qemu in u-boot_2021.07 recipe
- Fix Fix v3d & vc4 dmabuf import in mesa
- Recipe Upgrades
  - python3-importlib-metadata - 4.6.0, libffi - 3.4.2
  - xf86-input-libinput - 1.1.0, stress-ng - 0.12.11, libglu - 9.0.2
  - gpgme - 1.16.0, cmake - 3.20.5, intel-mediasdk - 21.2.3, gmmlib - 21.2.1
  - libva-intel - 2.12.0, babl - 0.1.88, dlt-daemon - 2.18.7
  - ctags - 5.9.20210627.0, can-utils - 2021.06.0, suitesparse - 5.10.1
  - redis - 6.2.4, mpd - 0.22.9, pango - 1.48.7, mesa - 21.1.4
  - libdrm - 2.4.107, texinfo - 6.8, rt-tests - 2.1, man-pages - 5.12
  - linux-yocto - 5.13.4, linux-libc-headers - 5.13, linux-yocto/5.4 - v5.4.134
  - linux-yocto/5.10 - v5.10.52, logcheck - 1.3.23, strongswan - 5.9.3
  - xscreensaver - 6.01, opencl-clhpp - 2.0.15, firewalld - 0.9.4
  - audit - 3.0.2, fftw - 3.3.9, keepalived - 2.2.2, poppler - 21.07.0
  - libgusb - 0.3.7, ristretto - 0.11.0, networkmanager - 1.32.2, cmark - 0.30.0
  - pipewire - 0-3.31, blueman - 2.2.1, mariadb - 10.5.11,
  - linux-ti-mainline - 5.13, at-spi2-core - 2.40.3, vulkan - 1.2.182
  - gnome-desktop-testing - 2021.1, xwayland - 21.1.2, webkitgtk - 2.32.2
  - stress-ng - 0.12.12, ruby - 3.0.2, mtools - 4.0.32, mpg123 - 1.28.2
  - libgit2 - 1.1.1, iproute2 - 5.13.0, harfbuzz - 2.8.2, gtk+3 - 3.24.30
  - ethtool - 5.13, createrepo-c - 0.17.4, bluez5 - 5.60, libmodulemd - 2.13.0
  - xserver-xorg - 1.20.12, llvm - 12.0.1, cups - 2.3.3op2, mesa - 21.1.5
  - btrfs-tools - 5.13, onevpl-intel-gpu - 21.3.0, qt5-creator - 4.15.2
  - libencode-perl - 3.11, libdbd-sqlite-perl - 1.68, libcurses-perl - 1.38
  - vboxguestdrivers - 6.1.24, libmbim - 1.26.0, gensio - 2.2.8, php - 7.4.21
  - networkmanager - 1.32.4, bats - 1.4.1, libtest-warnings-perl - 0.031
  - live555 - 20210720, postfix - 3.6.2, wireshark - 3.4.7, nghttp2 - 1.44.0
  - libtalloc - 2.3.3, libnet-dns-perl - 1.32, ctags - 5.9.20210718.0
  - cmark - 0.30.1, gnome-desktop3 - 3.38.8, gnome-backgrounds - 3.38.0
  - evince - 40.4, fluidsynth - 2.2.2, jack - 1.19.19, mtd-utils - 2.1.3
  - cmake - 3.21.0, libuv - 1.42.0, systemd - 249.1, llvm - 12.0.1
  - binutils - 2.37,
- New Recipes
  - ospray, openvkl, ispc, libyang, oidn, mbw, lmdb

## [2021.06] - 2021-06-30

- Update beagleV quickstart documentation
- Switch libuncontext to use meson
- Add support for erofs filesystems
- Fix mongodb, mariadb, vk-gl-cts, ovmf to build on musl/clang combination
- Fix dhcp-relay to build for musl
- Fix dovecot, heaptrack
- Fix libgpiod ptests
- Various packages fixed for set but unused clang warning
- Remove clutter, Cogl, and mx and its use from Core recipes
- Fix 96-boards tool to resize disks with GPT
- Use linux-starfive-dev kernel for beagleV
- Use u-boot device tree for OpenSBI fix SD card boot freeze on beagleV
- Use GPT again for beagleV wic image
- Fix wrong type for mutex in boost
- Upgrade clang to trunk/13.0 release
- Add recipes for native libcxx and compiler-rt
- Switch default compiler to clang and c/c++ runtime to llvm
- Do not force libgcc libunwind in rv32 and rv64 when using clang
- Add WM8960 soundcard support to RPI
- Remove deprecated linux-4-17 option from dbus-broker
- Fix klibc build with clang/compiler-rt
- Fix ffmpeg build on riscv32
- Add ppc64 SDK machine
- Re-add armv4 architecture support
- Add zsync conversions to image_types
- Package sysext in systemd-extra-utils
- Cleanup odroid-hardkernel recipes
- Fix overrides for IMAGE_FSTYPES in initramfs-debug-image generation
- Fix kernel do_sizecheck compare function
- Use 4 cores for qemuriscv32/qemuriscv64 emualation
- Move glibc ldso provider from musl to gcompat
- Backport fixes for ARC GCC
- Use Apache-2.0 implementation for `__stack_chk_fail`
- Fix libjpeg-turbo build on neon-less ARM
- Fix mariadb, mongodb, flashrom builds when using clang/musl
- Add rock64 machine in meta-rockchip
- Make rpi-cmdline machine specific
- Add ARC support to GDB
- Enable debuginfod on cross GDB
- Fix pkg-config for cross-canadian builds
- Fix rocksdb on riscv32, mips, and armv6+
- Make granular packageconfigs for czmq
- Add native build for net-snmp
- Add missing dbus dependency
- Fix QTbase for rk3399 wayland and eglfs builds
- Add second qmp port to qemurunner
- Enable multilib for do_populate_sdk
- Improve ARC support in toolchain components
- Fix Glibc Aarch64 MTE support
- Enhance devtool to rebase override-only patches as well
- Fix libpfm4 on aarch64
- Fix mpich and libc-bench to respect ldflags
- Add RISC-V support to ldconfig-native
- Fix SRC_URI for cantarell-fonts and libgudev
- Fix errors about read-only sstate mirrors
- Fix ntpdate to wait for subprocesses
- Recipe Upgrades
  - Curl - 7.77.0, kmod - 29, linux-firmware - 20210511, libxcrypt - 4.4.22
  - iproute2 - 5.12.0, libepoxy - 1.5.8, libpcre2 - 10.37
  - xorgproto - 2021.4.99.1, embedTLS - 2.26.0, poppler - 21.06.1
  - grpc - 1.38.0, libstemmer - 2.1.0, mpich - 3.4.2, gupnp - 1.2.6
  - thunar - 4.16.8, icewm - 2.3.4, dbus-broker - 29, nftables - 0.9.9
  - libx11 - 1.7.1, linux-intel-dev - 5.12.0, python3-setuptools - 57.0.0
  - linux-yocto/5.4 - v5.4.125, linux-yocto/5.10 - v5.10.43
  - opensaf - 5.21.06, fio - 3.27, gensio - 2.2.7, glog - 0.5.0
  - linux-fslc-imx - v5.4.126, linux-fslc-lts - v5.10.44, linux-fslc - v5.12.11
  - u-boot-fslc - v2021.07-rc4, at-spi2-core - 2.40.2
  - intel-microcode - 20210608, iozone3 - 492, pipewire - 0.3.30
  - modemmanager - 1.16.6, yelp - 40.2, gvfs - 1.48.1, libsigc++-2.0 - 2.10.7
  - libmediaart-2.0 - 1.9.5, toybox - 0.8.5, protobuf - 3.17.3
  - abseil-cpp - 20210324.2, speedtest-cli - 2.1.3, rasdaemon - 0.6.7
  - p11-kit - 0.23.24, vala - 0.52.4, epiphany - 40.2, diffoscope - 177
  - opkg - 0.4.5, git - 2.32.0, dtc - 1.6.1, go - 1.16.5, less - 590
  - ethtool - 5.12, gnutls - 3.7.2, liburcu - 0.13.0, rocksdb - 6.20.3
  - c-ares - 1.17.1, nodejs - 14.17.1, libpfm4 - 4.11.0
  - nfs-utils - 2.5.4, createrepo-c - 0.17.3, enchant2 - 2.3.0
  - blktrace - 1.3.0, alsa - 1.2.5.1, libpcap - 1.10.1, util-linux - 2.37
  - libX11 - 1.7.2, mpg123 - 1.28.0, xorgproto - 2021.4.99.2, apt - 2.2.4
  - meson - 0.58.1, ell - 0.41, m4 - 1.4.19, nettle - 3.7.3, grub - 2.06
  - glib-2.0 - 2.68.3, erofs-utils - 1.3, gptfdisk - 1.0.8, connman - 1.40
  - libwpe - 1.10.1, sudo - 1.9.7p1, wpebackend-fdo - 1.10.0, rng-tools - 6.13
  - libnss-mdns - 0.15.1, libksba - 1.6.0, rsyslog - 8.2106.0, nano - 5.8
  - rsnapshot - 1.4.4, mg - 20210609, googletest - 1.11.0
  - fsverity-utils - 1.4, ctags - 5.9.20210613.0, mosquitto - 2.0.11
  - evince - 40.2, fuse3 - 3.10.4, libzip - 1.8.0, iwd - 1.15, satyr - 0.38
  - libconfig - 1.7.3, grpc - 1.38.1, fwts - 21.06.00, function2 - 4.2.0
  - ctags - 5.9.20210620.0, snort - 2.9.18, openvpn - 2.5.3, qwt-qt5 - 6.1.5
  - mesa - 21.1.3, libxcrypt - 4.4.23, libva - 2.12.0, libhandy - 1.2.3
  - libcap - 1.2.3, libcap - 2.51, vte - 0.64.2, sqlite3 - 3.36.0
  - mtools - 4.0.31, libxi - 1.7.99.2, libpcre - 8.45, libdnf - 0.63.1
  - dejagnu - 1.6.3, bluez5 - 5.59, bind - 9.16.18, dnf - 4.8.0
  - bash - 5.1.8, cmake - 3.20.4, monit - 5.28.0, sshfs-fuse - 3.7.2
  - libtinyxml2 - 9.0.0, iputils - 20210202, shaderc - 2021.1
  - glslang - 11.5.0, spirv-tools - 2021.2
  - Various python recipe version bumps
  - Various gnome recipe version bumps
- New recipes
  - qperf, evemu-tools, zsync-curl, gcompat, gatord

## [2021.05] - 2021-05-31

- Add RISCV based BeagleV as supported board
- Add support for linux-starfive-dev kernel
- Fix xwayland dependency for weston in meta-freescale
- Add progress handler for S3 copy
- Upgrade imx firmware to 8.10.1
- Fix recipes for building with -ffile-prefix-map
- Upgrade to GCC 11.1.0
- Upgrade GDB to 10.2
- Fix patchelf note section alignment issues in uninative
- Upgrade mesa to 21.0.3
- Improve reproducibility for libjpeg-turbo
- Enable -Wdate-time to detect use of DATE TIME macros
- Enable long options for enabled applets in busybox
- Improve ptests for libpam and bash and valgrind
- Switch clang to use Dwarf-5 by default like GCC 11
- use 0x80008000 as the UBOOT_ENTRYPOINT for mx6ul, mx6ull and mx6ulz
- Update linux-fslc-imx to v5.4.122 and linux-fslc-lts to v5.10.40
- Add linux-fslc 5.12.7
- Enable serial and usbhost machine features for NanoPi-M4
- Bump linux-ti-mainline to 5.12
- Fix reproducibility for busybox
- Update linux-yocto trains to v5.4.119 and v5.10.38
- Fix kernel configs for qemuriscv32 to support only 1GB physical mem
- Fix SVN fetcher's parsing revision of SVN repos with redirects
- Update external-arm-toolchains to latest
- Add src files to nativesdk rust
- Use bb.utils.rename() instead of os.rename() in scripts
- Bump minimum required bitbake version to 1.51
- gdk-pixbuf updated to 2.42.6, glib-2.0 to 2.68.1, strate to 5.12
- Upgrade webkitgtk to 2.32.0
- Fix qtwebengine to build with gcc11 and upgrade to use chromium-87
- arm/trusted-firmware-m is updated to 1.3.0
- Upgrade XFCE components - xfce4-panel, xfce4-clipman-plugin,
  xfce4-systemload-plugin
- Fix CVE checks in QEMU, openssh, logrotate, jquery
- Upgrade busybox to 1.33.1
- Fix recipes to build with new definitions of SIGSTKSZ in glibc trunk
- Fix trusted-firmware-a for rockchip using GCC11/Clang12
- Backport DWARF-5 support for gold linker
- Update btrfs-tools to 5.12, ffmpeg to 4.4 and epiphany to 40.1
- Enable RISCV64 port for baremetal sample application helloworld
- Enhance yoe-sdk-image to include tools to build kernel on-device
- Update go to 1.16.4
- Update meson to 0.58.0
- Upgrade python to 3.9.5
- use 4 cores in qemu guests
- Update some of gnome components to facilitate 0.40.x release series
- Update bluez and wifi firmwares for RPI to rpt8 and rpt11 respectively
- Upgrade qemu to 6.0.0
- Handle sstate manifest 'corruption' issue
- Remove mklibs feature and support from core
- Fix default gcc search paths for musl configs and relocatable SDK fix
- CVE fixes in several packages
- Add compiler-rt-sanitizers, clang based sanitizers
- Upgrade uninative to 3.2 (gcc11 support)
- Fix `__NR_fstatat` syscall name for riscv/musl
- Upgrade U-Boot to 2021.04
- Fix clang static analyzer viewer for missing python module
- Update arm trusted-firmare-a to version 2.5
- Update gcc11 to latest on upstream GCC 11 release branch
- Update glibc to 2.33.1
- Enable memory tagging in glibc on aarch64
- Update systemd to 248.3
- Allow using gold linker with gcc-cross-canadian in SDK
- Various recipe version upgrades

## [2021.04] - 2021-04-27

- Upgrade linux-ti-staging kernel to 5.4.106
- Add new IMX8 machine imx8mp-ddr4-evk imx8mp-lpddr4-evk
- Upgrade hardkernel linux and u-boot to latest
- Fix linux-hardkernel build with GCC 11
- Disable qtwebkit and capnproto for RISCV32
- Update nodejs to 12.21.0
- Various recipe version upgrades
- Fix sstate reuse regression while building clang-native
- Fix native/host configuration in gobject-introspection
- Upgrade git to 2.31.1
- Add PR service support in eSDK
- Swich ODROID-C4 to use cortex-a55 tunes
- Fix and cleanup ODROID-N2 support
- Do not mark recipes commercial when the depndencies are commercial but not the
  package itself
- Make bpftool reproducable
- Update clang to 12.0.0-RC5 and do not use LLD to build nativesdk-clang
- Introduce support for armv8-4a arch
- Update linux-intel to 5.10.25 and v5.4.102
- Fix gcc 11 patch for odroid-c4-hardkernel kernel
- Add updater support for 32bit pi4
- Disable using u-boot for RPI images
- Always format disk after partitioning, avoids directory corruption
- Re-organize images to re-use common pieces
- Remove dosfstools to favor busybox mkfs.vfat applet in initramfs image
- Remove meta-altera BSP layer
- Fix huge wifi delay on imx6qdl-variscite-som
- Update linux-raspberrypi to 5.10.31
- Fix mesa-gl build regression on RPI
- Cleanup duplicate bbappends in meta-rockchip
- Add a knob for OpenMP threads in bitbake configuration
- Fix creation and generate new perl-rdepends.txt
- Upgade ptest-runner to 2.4.1
- Update mesa to 21.0.1
- Adjust for swrast being dropped from DRI drivers in mesa
- Fix sbsa-acs with clang
- Upgade syslog-ng to 3.31.2 and fix debug build
- Bump python to 3.9.4
- Update ICU to 69.1
- Upgrade go to 1.16.3
- Fix sysvinit-inittab getty launch on virtual consoles
- Upgrade ell to 0.39
- Upgrade webkitgtk to 2.30.6, wpebackend-fdo to 1.8.2, epiphany to 3.38.3
- Upgrade valgrind to 3.17.0 and fix valgrind ptests for DWARF-5/GCC11
- Update GCC to 10.3.0
- Fix glibc-src package name
- Fix DEBUG_PREFIX_MAP for gcc-runtime/libstdc++
- glib-2.0 upgraded to 2.68.0
- External src now detects code changes in submodules
- Add support for 8DXLite EVK with DDR3
- Cleanup Xorg recipes and patches for FSL boards
- Update linux-fslc to v5.10.32 and linux-fslc-imx to v5.4.114
- Update nodejs to 14.x LTS release
- Move libmicrohttpd to OE-Core
- Update PHP to 7.4.16
- Update linux-yocto kernels to v5.4.112 and v5.10.30
- Fix openssl dependencies in ca-certificate
- Use openssl as defualt SSL/TLS implementation where possible
- Add standalone xwayland and use it in weston images
- Add debuginfod distro feature
- Add --fetchdir parameter to layerindex-fetch
- Upgrade LLVM to 12.0.0
- Update musl to latest
- Upgrade openssh 8.5p1 -> 8.6p1
- Add support for ARMv5/ARMv4 in rust
- Fix yocto-check-layer script to work on multi layer repositories
- Override package default opts (-O2) with distro default opts for unzip/lz4
- Cleanups build dir before running configure for packages using cmake
- Do not export custom CLANG_TIDY variable
- Clean up meta-openembedded repositories for Yocto compatibility
- Move libseccomp to Core layer and enable it by default in DISTRO_FEATURES
- Fix nativesdk-clang build
- Update FSL EULA to v22
- Adjust recipes which were moved to OE-core
- Enable LTO linker plugin with binutils nm/ar/ranlib
- Fix qtwebengine with GCC 11
- Update qt5-creator to 4.14.2 and fix build with Clang 12

## [2021.03] - 2021-03-26

- Add Tinkerboad support
- Add Azure Storage fetcher implementation
- Add qemuppc64 machine
- Add REQUIRED_VERSION to bitbake
- Add NanoPi-M4 machine in rockchip soc layer
- Update go to 1.16.2 and remove go-dep
- Let linunwind on musl use libucontext
- Move qemuriscv32 machine as core machine
- Fix SRCREV for linux-altera-lts-5.4
- Compile musl on riscv64 when using meta-clang
- Update clang to 12.0.0-RC2
- Add recipe for spirv-llvm-translator
- Add opencv_4.4.0.imx recipe
- Bump linux-boundary to 5.4 2.3.0
- Bump linux-fslc to v5.10.30 and linux-fslc-imx to v5.4.112
- Drop 4.19 linux-fslc-lts
- Upgrade linux-yocto to v5.10.25 and v5.4.107
- Update openSSL to 1.1.1k
- Fix libtool race running autoheader before autoconf
- Update linux-ti-mainline to v5.11
- Fix qtwebkit build with riscv64
- QTbase fixes for build with GCC 11
- Fix recipes in meta-openembedded to work with GCC 11
- Fix sdcard_image-rpi to work with latest dosfstools
- Add adafruit python3 modules for raspberrypi
- Fix rust compiler and libstd-rs to work on riscv64/riscv32
- Disable CPU ISA level requirement check in glibc
- Add PSEUDO_IGNORE_PATHS foor SDK and image types
- Fix musl and busybox for RISCV32
- Fix systemd-container recipe
- Update Clang to 12.0.0 RC3
- Prevent fetching git hook during do_configure for ceres-solver
- Fix meta-qt5 recipes to compile with GCC 11 and RISCV fixes
- Fix a regression in glibc w.r.t. \_SC_LEVEL1_ICACHE_LINESIZE
- Add QB_GRAPHICS option to runqemu tool
- Add options to turn --enable-poison-system-directories fatal in GCC
- Reduce linker memory usage while building webkitgtk when using BFD linker
- Assorted XFCE package upgrades
- Fix several recipes for ppc64le
- Add imx-boot-container class to provide boot container for iMX
- Drop gatesgarth from compatible releases for layers
- Fix webkitgtk/JSC stack size on musl, add option to compile for size
- Update vulkan packages to 1.2.170.0
- Detect code changes in submodules when using externalsrc
- Fix bitbake documentation
- Update openSSH to 8.5p1
- Update gstreamer to 1.18.4
- Fix CPU tune file for rpi0w
- Fix compiler-rt for armv6/rpi0w
- Update rust to 1.51.1
- Fix PEP8 double aggressive warnings and errors in python scripts
- Make space for using IMX_DEFAULT_BOOTLOADER in meta-freescale-3rdparty
  machines
- Fix xorg and weston to adopt to mesa 21.x changes
- Improve bitbake documentation, add information on REQUIRED_VERSION
- Version upgrades for several recipes

## [2021.02] - 2021-02-26

- Upgrade autotools to 2.71
- Disable sanitizer builds in compiler-rt
- linux-fslc updated to v5.10.18, linux-fslc-imx updated to v5.4.100
- Fix qtwayland for mx6 and mx7 machines
- Enable DRI swrast driver for NXP BSPs
- Weston updated to 9.0.0
- Update linux-intel-rt to v5.10.12 and linux-intel/5.10 to v5.10.14
- Do not pin gcc for odroid-c4-hardkernel
- Upgrade binutils to 2.36.1
- Upgrade glibc to 2.33
- Update clang and llvm to 11.1.0
- Update to go 1.16 release
- Update busybox to 1.33
- Update python3 to 3.9.2
- Fix recipes to work with autotools 2.71, binutils 2.36
- Add 5.10 recipe for linux-raspberrypi and make it default
- Add overlays for pi 400 and cm4
- Fix compile issues in LTP, linux-yocto-5.10 for RISCV32
- Upgrade rust to 1.49.0
- Upgrade linux-yocto to v5.10.16 and v5.4.98
- Upgrade glslang to 11.1.0 and fix shaderc
- Detect code changes in submodules while using externalsrc
- Upgrade cmake to 3.19.3
- Various recipe version upgrades
- Use bitbake 1.49.2 and add support for BB_DEFAULT_UMASK
- Fix riscv32 u-boot, tcf-agent, and rust builds
- Use rust 1.49.x
- Update linux-ti-staging and u-boot to latest
- Fix glibc for faccessat2 seccomp filters
- Fix security flags and compiler opt level
- Upgrade u-boot to 2021.01
- Fix pseudo to handle faccessat
- Add recipe for libclc
- Merge llvm-common into clang
- Update linux-altera-lts_5.4 to 5.4.84
- Drop support for GCC 9.2 arm toolchain
- Pseudo fixes for glibc 2.33
- Update go to 1.15.8
- Update musl to latest master
- Fix various recipes for deterministic builds
- Various recipe version upgrades
- Add missing 'or-later' GPL license mappings
- Fix glibc multilib headers
- Use uboot 2021 release on odroid machines
- Fix bitbake providers processing
- Fixes for powerpc64 architecture in Core
- Enable gdbserver for riscv architecture

## [2021.01] - 2021-01-25

- Make meta-python dependency optional for meta-raspberrypi
- Upgrade raspberrypi-firmware and linux-raspberrypi to 5.4.79
- Fix zsh support in envsetup
- Fix install conflicts between canutils and can-utils recipes
- Refactor cdrkit and extend to build native version
- Update linux-at91 to linux4sam-2020.10-rc5
- Bump egt to 1.1-rc
- Bump linux-fslc to v5.10.6 and linux-fslc-imx to v5.4.88
- Update u-boot-toradex to 2020.07
- Fix RB5 board support
- linux-raspberrypi use linux-yocto tooling
- Fix X11 and wayland image builds with userland graphics
- Use relative symlinks for anything pulled from PREMIRRORS in fetchers
- Sam-ba is upgraded to 3.3.1
- u-boot-at91 updated to linux4sam-2020.10
- Added firmware for BCM43456
- linux-ti-staging updated to 5.4.78
- Update linux yocto to v5.4.87 and v5.10.4
- Assorted package version updates and reprodubility improvements
- Make busyboxinit work as an alternative to sysvinit
- Use util-linux provided fsck/fdisk in Yoe updater/installer
- Update go to 1.15.6 and disable internal linker for native apps
- Switch pulseaudion to use meson build system
- Update rust to 1.47 and enable separate build directory when using cargo
- Update clang to 11.1.0-rc2
- Update to qemu 5.2.0
- Add linux-intel-rt recipe for 5.10 and switch it as default kernel
- Switch odroid machine defaults to use 5.10 kernel
- Drop odroid-c2 from u-boot-hardkernel
- Upgrade XFCE to 4.16.0
- Assorted recipe upgrades
- Drop several old algorithms in OpenSSL
- Add finer packaging of sudo/iproute2/procps/net-tools
- Upgrade binutils to 2.35.1
- Upgrade mesa to 20.3.2
- Fix meson to work in nativesdk environment
- Add LFS support in bitbake fetcher
- Update Freescale EULA to v17
- Add new board i.MX DXL EVK
- Add i.MX 6ULZ EVK board
- Update gstreamer to 1.18.3
- Update bash to 5.1
- Fix ccache usecases, disable for native recipes
- Add support for VHD/VHDX rootfs in runqemu
- Upgrade linux-raspberrypi to v5.4.83
- Upgrade musl to 1.2.2
- Upgrade timezone data to 2021a
- Upgrade mariadb to 10.5.8

## [3.3.0-beta] - 2020-11-24

- Updater support added for beaglebone, rpi4-64, rpi3, and sama5d27
- Add yoe-install-image for factory install
- Use kernel+initramfs always for non-qemu machines
- Fix LTO builds with clang
- Fix Perf on IMX platforms
- Update intel-microcode to 20201112
- mchp-wireless-firmware: bump to 15.4.1
- Clang updated to 11.0.1
- Fix Numpy runtime issue when build with clang
- Update ODROID-N2 to use u-boot 2020.10
- Fix touchscreen with linux-hardkernel on C4
- Many packages fixed to build for RISCV32
- Update linux-yocto to v5.4.75 v5.8.18
- Enable Qemu Usermode on RISCV32
- Update linux-altera to 5.4.64
- Update linux-fslc to v5.4.80
- Disable LTO for qtbase
- Various package version upgrades
- Update golang to 1.15.5
- Update linux-yocto to latest 5.4.78
- Fix world builds for RISCV-32

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
- Update FSL EULA to LA_OPT_NXP_Software_License v11 February 2020
- Fix asound.conf for cubox-i
- Update linux-ti-staging to 5.4.69
- Update linux-fslc-imx/linux-fslc to v5.4.111 and v5.10.29
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
- Update RPI firmware to 20190114-1+rpt8
- Update linux-raspberrypi to 5.4.69
- Enable LTP builds on riscv32/musl
- Support ARMv8.2a tunes
- Add faster 34Kf-64tlb Qemu machines
- Update linux-yocto v5.8.13/v5.4.69
- Add ttarget RISCV64/RISCV32 builds for clang
- Fix GCC11 patch for odroid-c4-hardkernel kernel
- Common cleanups for meta-odroid layer
- Use XFCE for desktop on X11 kiosk image

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

[unreleased]: https://github.com/YoeDistro/yoe-distro/compare/2021.12...HEAD
[2021.12]: https://github.com/YoeDistro/yoe-distro/compare/2021.11...2021.12
[2021.11]: https://github.com/YoeDistro/yoe-distro/compare/2021.10...2021.11
[2021.10]: https://github.com/YoeDistro/yoe-distro/compare/2021.09...2021.10
[2021.09]: https://github.com/YoeDistro/yoe-distro/compare/2021.08...2021.09
[2021.08]: https://github.com/YoeDistro/yoe-distro/compare/2021.07...2021.08
[2021.07]: https://github.com/YoeDistro/yoe-distro/compare/2021.06...2021.07
[2021.06]: https://github.com/YoeDistro/yoe-distro/compare/2021.05...2021.06
[2021.05]: https://github.com/YoeDistro/yoe-distro/compare/2021.04...2021.05
[2021.04]: https://github.com/YoeDistro/yoe-distro/compare/2021.03...2021.04
[2021.03]: https://github.com/YoeDistro/yoe-distro/compare/2021.02...2021.03
[2021.02]: https://github.com/YoeDistro/yoe-distro/compare/2021.01...2021.02
[2021.01]: https://github.com/YoeDistro/yoe-distro/compare/3.3.0-beta...2021.01
[3.3.0-beta]:
  https://github.com/YoeDistro/yoe-distro/compare/3.3.0-alpha...3.3.0-beta
[3.3.0-alpha]:
  https://github.com/YoeDistro/yoe-distro/compare/3.2.0...3.3.0-alpha
[3.2.0]: https://github.com/YoeDistro/yoe-distro/compare/3.2.0-rc.1...3.2.0
[3.2.0-rc.1]:
  https://github.com/YoeDistro/yoe-distro/compare/3.2.0-beta...3.2.0-rc.1
[3.2.0-beta]:
  https://github.com/YoeDistro/yoe-distro/compare/3.2.0-alpha...3.2.0-beta
[3.2.0-alpha]: https://github.com/YoeDistro/yoe-distro/releases/tag/3.2.0-alpha
