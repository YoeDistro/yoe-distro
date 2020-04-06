# Yoe Docker Integration

[up](README.md)

The Yoe project provides a
[docker container](https://hub.docker.com/r/yoedistro/yoe-build/) that has all
the dependencies needed to build Yoe. This container is mostly transparent as it
simply wraps the bitbake command. Every time you run bitbake, the container is
started and all bitbake operations happen in the container. The build files
still exist in the host file system so they can be accessed using any of your
host tools.

Using this container has the following benefits:

- you don't have to worry about installing host dependencies
- you can build on any Linux host distro, even those that are not compatible
  with Yoe
- as host distributions are updated, then eventually become incompatible with
  older versions of OpenEmbedded. Using a container allows you to build old
  version of Yoe over long product life cycles.

Yoe uses docker by default, but this can be disabled by setting
`DOCKER_REPO=none` in your _\<project\>-envsetup.sh_ file. You can also set
`DOCKER_REPO` to a custom container if you need something different.

Any tool (such as `devtool`) that uses bitbake must also be run in the
container. As these tools are not yet wrapped, you must enter the docker
container first, and then run the tool. This can be done by running `dkr` first,
which drops you into a container shell.
