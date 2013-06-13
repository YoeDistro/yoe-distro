BEC OE-core build template

Build system based on oe-core, OpenEmbedded, and Angstrom.

EXAMPLE
=======

This following is example of building and installing a linux system from
scratch on the BeagleBoard.

* git clone git://github.com/cbrake/oe-build-core.git
* cd oe-build-core
* . envsetup.sh
* oe_setup
* bitbake systemd-image
* <insert SD card>
* lsblk (note sd card device)
* oe_partition_sd /dev/sdX
* oe_install_sd_boot (install MLO, u-boot, kernel)
* oe_install_sd_rootfs_systemd_gnome_image
* <install SD card in beagleboard and enjoy your new image>

MOTIVATION
==========

This build template is designed to be used for product
build systems (used to build product software), and thus
has the following goals:

1. simplicity: uses well understood things like bash and
   git submodules.
1. robustness: git submodules may be a pain, but they are
   a robust solution for production environments, and 
   error handling is pretty good.
1. generate a modern Linux root filesystem.
1. uses systemd

USING
=====

In general, this build system must be run in a bash shell.
To set up the environment, source the following file:

. envsetup.sh

This file will create a bunch of functions in the environment
prefixed with oe_ that can be executed.  Type oe_ <tab><tab>
to see them.

Information on various files/directories:
  - build: temporary directory where build actually takes place
  - conf: configuration files for the build
  - sources: various sources used for the build.  Most entries
    in this directory are git submodules, but the downloads
    directory contains files that are downloaded by various
    recipes during builds.
  - scripts: utility scripts
  - localconfig.sh: file created by  envsetup.sh that contains
    directory specific variables based on the build system location.

To add a new layer:

  git submodule add <git URI> sources/meta-mylayer
  add layer to conf/bblayers.conf

conf/local.conf contains settings that are commonly modified such
as parallel build options.

Tested Targets
==============

* BeagleBoard
** BSP components from meta-ti
** 3.2 kernel
* BeagleBone
** BSP components from meta-beagleboard
** 3.8 kernel
* Gumstix Overo
** BSP components from meta-gumstix-community
** 3.5 kernel

LICENSE
=======

This build system is licensed under the MIT license which is the
same license as oe-core, etc.  See COPYING.MIT

Contributions are welcome: please email cbrake@bec-systems.com


