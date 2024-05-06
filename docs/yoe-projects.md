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

## Converting a project

If you used yoe before you might want to convert a project to the new config. In
the simplest case you just need to create a new directory at
`conf/project/jour_project_name` and copy over your `local.conf` to
`config.conf` and bblayers.conf to layers.conf.

## Creating a new project

Choose a project which asembles your needs most from the projects copy it to
`conf/project/jour_project_name` and change it to your needs.

## Modifying an example project (ex: SOM baseboard)

A very common scenario is that you might want to create a custom baseboard for a
SOM (system on module). You want to start with the SOM vendors reference
baseboard, but customize to the changes you have made. In this case it is very
useful to have a separate `PROJECT` and `MACHINE` so that you can build images
for the reference board and your custom board in one build system. The steps to
do this includes:

1. create a new machine conf in
   `sources/meta-<your custom layer>/conf/machine/mymachine.conf`. This is
   typically a copy of the baseboard machine conf file.

## Contribute

If you feel like your project config fits the yoe-distribution well feel free to
start a pull request.
