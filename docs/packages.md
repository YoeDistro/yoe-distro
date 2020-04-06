# Packages

[up](README.md)

During an image build, OpenEmbedded builds all software into packages, which are
then combined into a rootfs. One benefit of this is you can install packages
later into a running system, much like you would a desktop distribution like
Debian, Ubuntu, Arch, etc. OE supports the RPM, DEB, and IPK package formats,
and the format can be set using the
[PACKAGE_CLASSES](https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#var-PACKAGE_CLASSES)
variable.

## Installing packages from a local build

You can install packages directly from your local OE build onto a target system
with the following procedure:

- packaging information must be included in the target image:
  - `IMAGE_FEATURES += "packages-management"`
- a ssh server must be enabled in the target image:
  - `IMAGE_FEATURES += "ssh-server-dropbear"`
- see
  [yoe-simple-image](https://github.com/YoeDistro/meta-yoe/blob/master/recipes-core/images/yoe-simple-image.bb)
  for an example.
- target system must be on the same network as your build computer.
- run `yoe_setup_feed_server <target ip address>`. This configures the target to
  fetch packages from your build computer. Alternatively you can set the
  MACHINE_IP environment variable.
- run `yoe_feed_server`. This starts a web server that serves packages.
- on target system, run:
  - `opkg update`
  - `opkg list` (list packages available)
  - `opkg install python3` (install python3)

If the package is not built yet, simply:

- `bitbake <recipe for package to install>`
- `bitbake package-index` (required to rebuild the package index)
- on target:
  - `opkg update`
  - `opkg install <package>`

This technique is very useful for testing new packages, or for installing
packages that are only needed for development that you don't want to include in
production images (strace, gdb, testing tools, etc). Dependencies are
automatically handled by the package manager.

For larger development teams or field deployments, you might want to set up a
feed server to serve packages to any connected device.

See also:

- https://www.yoctoproject.org/docs/latest/mega-manual/mega-manual.html#package-feeds-dev-environment
- https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#var-FEED_DEPLOYDIR_BASE_URI
