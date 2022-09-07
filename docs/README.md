# Yoe Documentation

See the Yoe [readme](../README.md) for an overview of the project. This page is
an index to more detailed documentation.

## Machine Documentation

The Yoe distribution includes support for a number of common target machines.
Notes are included for some of them below.

- [Raspberry PI](raspberrypi.md)
- [BeagleBone Black](beagleboneblack.md)
- [ODROID](odroid.md)

## Using Yoe

- [Docker Integration](docker.md)
- [Packages](packages.md) - information on installing packages from your build
  directory in a development scenario.
- [Working with git submodules](git-submodules.md)

## Image Configuration

OpenEmbedded supports a wide range of technology choices. Some of these are
documented below.

- [Configuration Files](conf-files.md)
- [Profile](yoe-profile.md)
- [libc/init system](libc-init.md)
- [adding GCC and development tools to target system](gcc.md)

## Design Choices

- [Superproject Management](superproject-management.md)
- [Layer Management](layer-management.md)

The Yoe documentation is kept with the project as simple markdown files in the
docs/ subdirectory. We do not use the Github wiki, document generators, or other
more sophisticated methods for the following reasons:

- it is obvious where to find documentation
- the documentation for the version of Yoe you are using is always available,
  even through long product life cycles
- simpler for others to contibute improvements

## Build Machine Requirements

Build machine requirements vary depending on what you are building. You may get
by with 8GB of RAM for simple images, but building anything with Chromium in it
will likely require 64GB of RAM. We recommend at least 16GB and preferably 32 or
64GB.

Yocto agressively parallizes the build, so it will max it your CPUs. Generally,
you need to have 2GB of RAM for each virtual core. To determine the number of
cores, run `cat /proc/cpus` and locate the `siblings` field. For x86 CPUS, this
is typically twice the number of CPU cores due to hyperthreading.

```
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 23
model           : 113
model name      : AMD Ryzen 9 3900X 12-Core Processor
stepping        : 0
microcode       : 0x8701021
cpu MHz         : 2200.000
cache size      : 512 KB
physical id     : 0
siblings        : 24
core id         : 0
cpu cores       : 12
```

For the above above 12 core machine, we have 24 virtual cores, so need ~48GB of
RAM.

If you are running out of memory during builds, you can add the following to
`local.conf`:

```
PARALLEL_MAKE = "-j 11"
BB_NUMBER_THREADS = "11"
XZ_THREADS = "8"
# Max 10% of memory to be used during parallel xz
XZ_MEMLIMIT = "10%"
```

A single build can take 50GB of disk space or more. SSD drives speed up builds
quite a bit over rotating disks.
