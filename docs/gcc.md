# GCC

[up](README.md)

The primary use for OE is to cross-compile software on a fast workstation, but
there are times during development or evaluating technology where it may be
useful to compile software on the target device. There is also some software
that is simply too nasty for most of us to figure out how to cross-compile so
one workaround is to build a binary on the target system, and then package that
binary in subsequent image builds. This _hack_ should only be used as a _last
resort_ in production builds.

The following packages can be added to the image, or installed at runtime using
a package manager such as opkg.

- `packagegroup-core-buildessential` - this is most often what you need and is
  very similiar to the build-essential package on Debian/Ubuntu.
  [recipe](https://github.com/YoeDistro/openembedded-core/blob/master/meta/recipes-core/packagegroups/packagegroup-core-buildessential.bb)
- `packagegroup-self-hosted` - a much more extensive list of packages that
  includes what is in buildessential, plus a lot more.
  [recipe](https://github.com/YoeDistro/openembedded-core/blob/master/meta/recipes-core/packagegroups/packagegroup-self-hosted.bb)
