DISTRO_FEATURES:remove = " x11 wayland"
DISTRO_FEATURES_NATIVESDK:append = " wayland"
DISTRO_FEATURES_NATIVE:append = " wayland"
# Use rdk backend for eglfs
PREFERRED_PROVIDER_virtual/wpebackend = "wpebackend-rdk"
