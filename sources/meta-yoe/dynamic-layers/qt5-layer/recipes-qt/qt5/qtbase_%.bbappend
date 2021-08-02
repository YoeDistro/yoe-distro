# This does not work when wayland and x11 both are enabled in DISTRO_FEATURES and x11 image
# is built but works ok for eglfs and wayland images
QT_CONFIG_FLAGS += "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '-qpa wayland', \
                                         bb.utils.contains('DISTRO_FEATURES', 'x11', '', \
                                                          '-qpa eglfs', d), d)}"

PACKAGECONFIG:append = " libinput eglfs examples linuxfb tslib"

PACKAGECONFIG_GL = "${@bb.utils.contains('DISTRO_FEATURES', 'x11 opengl', 'gl', \
                    bb.utils.contains('DISTRO_FEATURES',     'opengl', 'eglfs gles2', \
                                     '', d), d)}"
