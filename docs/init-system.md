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

* SysVinit: 4.7MB
* Systemd: 33.2MB

(the above sizes are being investigated, as they may not be accurate).
