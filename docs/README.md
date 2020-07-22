# Yoe Documentation

See the Yoe [readme](../README.md) for an overview of the project. This page is
an index to more detailed documentation.

## Machine Documentation

The Yoe distribution includes support for a number of common machines. Notes are
included for some of them below.

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
