DISTRO_FEATURES:remove = " x11 wayland"

# Use bcm userland graphics driver
DISABLE_VC4GRAPHICS = "1"

# Use rdk backend for eglfs
PREFERRED_PROVIDER_virtual/wpebackend = "wpebackend-rdk"

PACKAGECONFIG:pn-wpebackend-rdk:rpi = "rpi"
