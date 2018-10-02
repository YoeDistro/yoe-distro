![Yoe](docs/yoe.png?raw=true =200x200)

# Yoe Embedded Linux Distribution

Yoe is an Embedded Linux Distribution optimized for product development.
It is built on **Y**octo and **O**pen**E**mbedded with a focus on simplicity.

## Example

This following is example of building and installing a linux system from
scratch on a Raspberry PI 3:

* git clone git://github.com/YoeDistro/yoe-distro.git
* cd yoe-distro
* . raspberrypi3-64-envsetup.sh
* yoe_setup
* bitbake core-image-minimal
* [insert SD card]
* lsblk (note sd card device)
* yoe_partition_sd /dev/sdX
* yoe_install_sd_boot (install MLO, u-boot, kernel)
* yoe_install_sd_rootfs_systemd_image
* [Install SD card in a Raspberry PI and enjoy your new image]
* yoe_console (fire up a serial console for the machine)

## Motivation

This build template is designed to be used for production
build systems (used to build products), and thus
has the following goals:

1. simplicity: uses well understood things like bash and
   git submodules.
1. robustness: Git submodules are
   a robust solution for production environments, and
   error handling good. Git submodules are also very good at making
   sure you are building exactly what was checked in, because it locks every
   submodule down to a specific version, which is generally what you want for a production
   build system, where the build must be absolutely repeatable.
1. modern: generate a modern Linux root filesystem using the latest technologies
1. broad platform support: support a range of common development platforms, system on
   chips (SoC), and system on modules (SOM)
1. extendable: simple to modify and add your own custom software to the system

## Tested Machines

See the \<machine\>-envsetup.sh files for examples of machines we regularly test with.

## Using

### envsetup.sh

This is where all the magic happens. In general, this build system
must be run in a bash shell. To set up the environment, source the following file:

. ./\<machine\>-envsetup.sh

Or, you can export a MACHINE environment variable, and then source envsetup.sh.

This file will create a bunch of functions in the environment
prefixed with yoe\_ that can be executed. Type yoe\_ <tab><tab>
to see them.

### directories and key files

* build: temporary directory where build actually takes place
* conf: configuration files for the build
* sources: various sources used for the build. The entries
  in this directory are git submodules.
* downloads: contains files that are downloaded by various
  recipes during builds.
* tools: utility scripts
* localconfig.sh: file created by envsetup.sh that contains
  directory specific variables based on the build system location.
* local.sh: can be used to customize MACHINE, and other variables

### building for another machine

* export MACHINE=[my machine]
* bitbake [recipe name]

### adding a new layer

* Adding rocko branch of meta-altera layer to layer mix

yoe_add_layer https://github.com/kraj/meta-altera rocko

### removing a new layer

* Remove meta-altera

yoe_remove_layer meta-altera

### customizing settings

conf/local.conf contains settings that are commonly modified such
as parallel build options.

### starting a local feed server

Sometimes you want to install packages you build on the target system
without building and re-installing the entire rootfs. This can be done
using a feed server.

* Workstation: yoe_feed_server (this starts a feed server on port 4000)
* Target: modify /etc/opkg to http://[your workstation IP]:4000
* Target: opkg update
* Target: opkg install [package]

This advantage of a feed server versus scp'ing opkg files to the target
and installing manually is that dependencies will automatically get installed.
This mechanism is very useful for packages that are only needed occasionally
during development (gdb, screen, strace, iperf, etc).

### updating the submodules to the latest

Assuming you have a recent version of git, you can make use of the branch
values specified in .gitmodules to update each submodule branch to the
HEAD of the specified branch:

```git submodule update --remote```

## License

This build system is licensed under the MIT license which is the
same license as oe-core, etc. See COPYING.MIT

Contributions are welcome: please email cbrake@bec-systems.com
