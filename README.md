<img src="docs/yoe.png?raw=true" width="150">

# Yoe Embedded Linux Distribution

Yoe is an Embedded Linux Distribution optimized for product development.
It is built on **Y**octo and **O**pen**E**mbedded with a focus on simplicity.
This distribution does not end at demo images but rather begins there.

## Example

This following is example of building and installing a linux system from
scratch on a Raspberry PI 3:

* git clone git://github.com/YoeDistro/yoe-distro.git
* cd yoe-distro
* . raspberrypi3-64-envsetup.sh
* yoe_setup
* bitbake core-image-minimal
* [insert SD card]
* lsblk (note sd card device, and substitute for /dev/sdX below)
* yoe_install_wic_image /dev/sdX core-image-minimal
* optional: [configure console for serial port](docs/raspberrypi.md)
* sudo eject /dev/sdX
* [Install SD card in a Raspberry PI and enjoy your new image]

## Vision

There are many examples of build systems out there that are based on Yocto.
There is the Poky reference distribution. Most SOC and SOM vendors provide
a Yocto variant that supports their products (often put together with repo).
While these all provide good ways to build demo images, we feel something
slightly different is needed for product development. Thus, the following
goals:

1. **simple**: directory layout is logical so it is easy to find things, and tooling
   is as simple as possible. Emphasis is on logical organization, minimal magic, and good
   tooling where it makes sense. We try to minimize uneeded indirection or abstraction
   unless it really adds value.
1. **modern**: generate a modern Linux root filesystem using the latest technologies.
1. **broad platform support**: support a range of common development platforms, system on
   chips (SoC), and system on modules (SOM). You should not have to use a different
   build system for every SOC/SOM you might choose to use in your products.
1. **repeatable**: easy to lock down subprojects (layers) to known versions for
     repeatable builds
1. **extendable**: simple to modify and add your own custom software, scripts and tooling.
   The focus is not in hiding or abstracting Yocto functionality, but rather provider simpler
   and clearer ways to use it.
1. **maintainable**: product lifecycles run for many years, so we need a solution where
   we can build images on a number of different hosts as time marches on. We achieve this
   through a simple and transparent docker wrapper that contains all the host dependencies
   needed. This wrapper is invisible (the file system still lives on the host), and is
   optional if you choose not to use it.
1. **transparent**: we try to use industry standard tools (git, bitbake, etc) where possible
   and not invent a lot of new tooling that needs to be learned to use the system.
   As an example, much of the tooling (envsetup.sh) are simple bash functions and are easy
   to learn from. Using Yoe will teach you about Yocto.
1. **minimal**: Embedded Linux images can quickly become bloated so we support technologies
   like musl libc, opkg package manager, etc. where appropriate.

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

* _build_: temporary directory where build actually takes place
* _conf_: configuration files for the build
* _sources_: various sources used for the build. The entries
  in this directory are git submodules.
* _downloads_: contains files that are downloaded by various
  recipes during builds.
* _tools_: utility scripts
* _localconfig.sh_: file created by envsetup.sh that contains
  directory specific variables based on the build system location.
* _local.sh_: can be used to customize MACHINE, and other variables

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

Contributions are welcome: please file issues or open pull requests.
