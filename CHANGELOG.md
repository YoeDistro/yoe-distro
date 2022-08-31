# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to
[Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
- Updated linux-yocto to v5.15.62, v5.19.3
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

- Add recipe for mdio-tools, usbmuxd, libusbmuxd, libimobiledevice,
  libplist, gst-editing-services, uutils-coreutils, python3-asgiref
- Added clang-native class to build native compoennts with clang
- Add test for debuginfod

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
  python3-jsonrpcclient, python3-aiodns, python3-pycares
  waylandpp, python-requests-unixsocket, sshpass
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

- Added recipes
  libavtp, libtomcrypt, flite
- Add QB_KERNEL_CMDLINE to runqemu

### Removed

## [2022.05] - 2022-05-31

### Changed

- Update meta-ti recipes to SDK 08.02.00.005
- Let the user drive the update interval for CVE database
- Correctly handle file names containing colons in bitbake
- Fix firmware autoloading for rpi by creating
  brcmfmac43455-sdio.raspberrypi,4-model-b.bin symlink
- Update qemu to 7.0.0
= Upgrade musl to tip of trunk
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
  python3-eth-keyfile, python3-eth-keys, python3-eth-utils
  python3-eth-typing, python3-eth-hash, python3-decouple
  python3-cytoolz, python3-toolz, python3-inotify, nodejs-oe-cache-native
  overlayfs-progs, overlayfs-tools, python3-uinput, xfstests
  python3-editables, python3-hatchling, python3-pathspec
  python3-setuptools-scm-git-archive

### Removed

- Remove meta-networking dependency on meta-python by re-arranging
  recipe locations
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
