inherit features_check

X11PKGS = "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '', 'packagegroup-core-x11 packagegroup-xfce-base', d)}"
X11ONLYPKGS = "${@bb.utils.contains('DISTRO_FEATURES', 'x11', '${X11PKGS}', '', d)}"
X11FEATURE = "${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '', 'x11', d)}"
X11FEATUREONLY = "${@bb.utils.contains('DISTRO_FEATURES', 'x11', '${X11FEATURE}', '', d)}"

IMAGE_FEATURES += "splash \
                   ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston', '', d)} \
                   ${X11FEATUREONLY} \
                  "
CORE_IMAGE_EXTRA_INSTALL += " \
  ${@bb.utils.contains('DISTRO_FEATURES', 'wayland x11', 'weston-xwayland', '', d)} \
  ${X11ONLYPKGS} \
"
SYSTEMD_DEFAULT_TARGET = "graphical.target"
