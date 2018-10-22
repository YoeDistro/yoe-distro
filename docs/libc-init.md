# libc and init system selection

[up](README.md)

## Systemd

SysVinit and Systemd are common init systems. SysVinit is the default, but Systemd can
be enabled be adding the following to local.conf:

```
DISTRO_FEATURES_append = " systemd"
VIRTUAL-RUNTIME_init_manager = "systemd"
DISTRO_FEATURES_BACKFILL_CONSIDERED = "sysvinit"
VIRTUAL-RUNTIME_initscripts = ""
```

There is a significant size cost with systemd, so in some cases it may make sense to
use sysvinit if image size is a priority.

## Busybox Init

Busybox can also be used as an init system with the following in local.conf:

```
VIRTUAL-RUNTIME_init_manager = "busybox"
VIRTUAL-RUNTIME_dev_manager = "busybox-mdev"
VIRTUAL-RUNTIME_login_manager = "busybox"
```

## Libc selection

glibc is the default libc, but musl can also be used by setting the following in
local.conf:

```
TCLIBC = "musl"
```

## Comparison of disk spaced used

- Musl + Busybox init/dev/login
  - space used in ext4 filesystem on running system using df: 1.9MB
  - adding sizes of files in image from buildhistory: 1.5MB
  - number of files in image: 595
- Busybox init/dev/login
  - space used in ext4 filesystem on running system using df: 3.5MB
  - adding sizes of files in image from buildhistory: 3.1MB
  - number of files in image: 621
- SysVinit
  - space used in ext4 filesystem on running system using df: 4.7MB
  - adding sizes of files in image from buildhistory: 4.3MB
  - number of files in image: 696
- Systemd
  - space used in ext4 filesystem on running system using df: 33.2MB
  - adding sizes of files in image from buildhistory: 22MB
  - number of files in image: 1,806

The space on disc used by a systemd image is much larger than adding the size of
the files in the image. We're not sure why this is -- perhaps there is filesystem
overhead for small files.
