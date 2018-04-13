require initramfs-image.bb

PACKAGE_INSTALL += "\
  psplash \
  "


export IMAGE_BASENAME = "initramfs-image-splash"


