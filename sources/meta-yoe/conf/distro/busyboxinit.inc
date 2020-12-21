# enable busybox for init
DISTRO_FEATURES_BACKFILL_CONSIDERED_append = " systemd"
VIRTUAL-RUNTIME_init_manager = "busybox"
VIRTUAL-RUNTIME_initscripts = "initscripts"
VIRTUAL-RUNTIME_keymaps = "keymaps"
VIRTUAL-RUNTIME_login_manager = "busybox"
