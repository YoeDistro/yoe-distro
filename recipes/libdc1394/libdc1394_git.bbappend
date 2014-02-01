# This patch is not in upstream dora once its applied we will
# remove the append

DEPENDS += "libxv virtual/libsdl virtual/libx11 libusb1 libraw1394 \
            ${@base_contains('DISTRO_FEATURES', 'opengl', 'virtual/libgl libglu', '', d)}"
 
