# Yoe Documentation

See the Yoe [readme](../README.md) for an overview of the project.
This page is an index to more detailed documentation.

## Machine Documentation

The Yoe distribution includes support for a number of common machines. Notes are
included for some of them below.

- [Raspberry PI](raspberrypi.md)
- [BeagleBone Black](beagleboneblack.md)
- [ODroid-C2 -- todo]()

## Using Yoe

- [Working with git submodules](git-submodules.md)

## Image Configuration

OpenEmbedded supports a wide range of technology choices. Some of these are documented
below.

- [libc/init system](libc-init.md)

## Design Choices

- [Superproject Management](superproject-management.md)
- [Layer Management](layer-management.md)

The Yoe documentation is kept with the project as simple markdown files in the docs/
subdirectory. We do not use the Github wiki, document generators, or other more
sophisticated methods for the following reasons:

- it is obvious where to find documentation
- the documentation for the version of Yoe you are using is always available, even
  through long product life cycles
- simpler for others to contibute improvements
