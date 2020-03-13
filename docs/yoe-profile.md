# Yoe Profile

[up](README.md)

The Yoe Distribution makes it easy to select the libc, init, and graphics
subsystem for your project. To select a profile, set `YOE_PROFILE` in
`conf/site.conf` equal to one of the following:

- yoe-glibc-busyboxinit-eglfs
- yoe-glibc-busyboxinit-wayland
- yoe-glibc-busyboxinit-x11
- yoe-glibc-systemd-eglfs
- yoe-glibc-systemd-wayland
- yoe-glibc-systemd-x11
- yoe-glibc-sysvinit-eglfs
- yoe-glibc-sysvinit-wayland
- yoe-glibc-sysvinit-x11
- yoe-musl-busyboxinit-eglfs
- yoe-musl-busyboxinit-wayland
- yoe-musl-busyboxinit-x11
- yoe-musl-systemd-eglfs
- yoe-musl-systemd-wayland
- yoe-musl-systemd-x11
- yoe-musl-sysvinit-eglfs
- yoe-musl-sysvinit-wayland
- yoe-musl-sysvinit-x11

These profiles are provided for convenience. You can manually configure these
options as well -- use the files in the yoe
[conf directory](https://github.com/YoeDistro/meta-yoe/tree/master/conf/distro)
for reference.
