# Use systemd for system initialization
INIT_MANAGER = "systemd"
# Use dbus broker instead of traditional dbus daemon
# It's more modern and robust although might take a bit extra memory ( 8MB )
VIRTUAL-RUNTIME_dbus = "dbus-broker"
