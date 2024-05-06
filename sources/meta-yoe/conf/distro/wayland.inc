DISTRO_FEATURES:append = " wayland"
DISTRO_FEATURES_DEFAULT:remove = "x11"
PACKAGECONFIG:append:pn-cog:rpi = " drm"
