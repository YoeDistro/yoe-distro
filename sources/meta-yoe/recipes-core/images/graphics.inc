inherit features_check

REQUIRED_DISTRO_FEATURES = "opengl"

IMAGE_FEATURES += "splash \
                   ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston', '', d)} \
                  "
CORE_IMAGE_BASE_INSTALL += " \
 ${@bb.utils.contains('DISTRO_FEATURES', 'wayland x11', 'weston-xwayland', '', d)} \
  gstreamer1.0-libav \
"

# Ptest needs more RAM ( > 256M ) on QEMU
QB_MEM = "-m 1024"
