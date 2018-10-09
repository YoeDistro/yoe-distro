# Init System

SysVinit and Systemd are common init systems. SysVinit is the default, but Systemd can
be enabled be adding the following to local.conf:

```
DISTRO_FEATURES_append = " systemd"
VIRTUAL-RUNTIME_init_manager = "systemd"
DISTRO_FEATURES_BACKFILL_CONSIDERED = "sysvinit"
VIRTUAL-RUNTIME_initscripts = ""
```

Systemd takes considerably more space than SysVinit. With a rPI2 build, the following
are the rootfs sizes for core-image-minimal:

* SysVinit
  * space used in ext4 filesystem on running system using df: 4.7MB
  * adding sizes of files in image from buildhistory: 4.3MB
  * number of files in image: 696
* Systemd
  * space used in ext4 filesystem on running system using df: 33.2MB
  * adding sizes of files in image from buildhistory: 22MB
  * number of files in image: 1,806

There is a significant size cost with systemd, so in some cases it may make sense to
use sysvinit if image size is a priority.
