# enable busybox for init and mdev for device manager
INIT_MANAGER = "mdev-busybox"

# We want to use sysvinit scripts to initialize a complete system
# default is bare system where init system needs to be told what to run
DISTRO_FEATURES:append = " sysvinit "
DISTRO_FEATURES_BACKFILL_CONSIDERED:remove = "sysvinit"
