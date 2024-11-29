# Yoe Projects

## Idea

The Yoe Distribution makes it easy to switch between projects. Before you had to
switch between local.conf and bblayers.conf a lot. With the introduction of the
conf/projects this got a lot easier. You can switch between a lot of pre made
projects. A project consists of a config.conf and a layers.conf file. The
layers.conf file is the bblayers.conf for that specific project. And the
config.conf is everything you would normally put into your local.conf file. To
choose between a configuration simpy do the following

```bash
. ./envsetup.sh beaglebone
yoe_setup
```

After this point you are able to bitbake e.g. yoe-simple-image for that
project/platform.

## Supported projects

Currently these projects are supported.

- beaglebone
- qemuarm
- qemuppc
- qemux86
- unleashed
- var-som-mx8m-nano
- imx8mm-ddr4-evk
- qemuarm64
- qemuppc64
- qemux86-64
- unmatched
- var-som-mx8x
- nezha-d1
- qemucommon
- qemuriscv32
- rockpi-4b
- var-dart-imx6ul
- visionfive
- odroid-c4
- qemumips
- qemuriscv64
- rpi4-64
- var-som-mx8
- visionfive2
- intel-x86-64

## Converting a project

If you used yoe before you might want to convert a project to the new config. In
the simplest case you just need to create a new directory at
`conf/project/jour_project_name` and copy over your `local.conf` to
`config.conf` and bblayers.conf to layers.conf.

## Creating a new project

Choose a project which asembles your needs most from the projects copy it to
`conf/project/jour_project_name` and change it to your needs.

## Supporting a custom SOM baseboard

A very common scenario is that you might want to create a custom baseboard for a
SOM (system on module). The starting point is the SOM vendor's reference
baseboard, but we need to customize the build to account for the differences
between the reference and custom baseboards. In this case it is very useful to
have a separate `PROJECT` and `MACHINE` so that you can build images for the
reference board and your custom board in one build system. This allows you to
easily compare the systems to debug problems. Steps to do this includes:

1. **machine conf**
   `sources/meta-<your custom layer>/conf/machine/mymachine.conf`. This
   typically requires the original baseboard machine conf file.
   - add: `MACHINEOVERRIDES =. "<ref machine name>:"`
   - specify custom machine DTB: `KERNEL_DEVICETREE = "freescale/mymachine.dtb"`
   - optionally specify custom uboot DTB:
     `UBOOT_DTB_NAME = "imx8qm-var-som-m80.dtb"`
   - specify kernel/uboot default providers (FIXME, is this required?)
1. **kernel bbappend**
   - adds your custom `mymachine.dts`
   - patch kernel to build `mymachine.dtb`
   - optionally create a custom kernel config or add config fragments to
     customize the kernel config
   - this should probably be put in a dynamic layer if the kernel recipe is
     found in a `meta-<...>` layer.
1. **updater config**
   `sources/meta-yoe/recipes-support/update/files/<mymachine>/`
   - generally, copying the reference design updater and changing a few
     variables in the `platform` file is enough.
1. **image update task**
   - copy reference machine `inc` file to:
     `sources/meta-yoe/recipes-core/images/machines/<mymachine>.inc`.
1. **custom Yoe project**
   - copy the reference design Yoe project to `conf/projects/<myproject>`
   - the `config.conf` should reference your custom `MACHINE`

## Contribute

If you feel like your project config fits the yoe-distribution well feel free to
start a pull request.
