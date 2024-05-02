DISTRO_FEATURES:append = " wayland"
DISTRO_FEATURES:remove = "x11"

PACKAGECONFIG:append:pn-cog:rpi = " drm"
