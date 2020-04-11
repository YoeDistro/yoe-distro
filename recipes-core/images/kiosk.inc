REQUIRED_DISTRO_FEATURES = "opengl"

IMAGE_FEATURES += "splash"

CORE_IMAGE_BASE_INSTALL += " \
 ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston weston-init weston-examples', '', d)} \
  cog \
  gstreamer1.0-libav \
  wpewebkit \
"
