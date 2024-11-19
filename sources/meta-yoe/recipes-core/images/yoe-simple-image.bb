# Yoe starter image

DESCRIPTION = "Yoe Starter Image"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit core-image
require updater.inc

IMAGE_FEATURES += "ssh-server-openssh package-management hwcodecs"

IMAGE_FEATURES += "allow-empty-password empty-root-password allow-root-login post-install-logging"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    packagegroup-base-wifi \
    packagegroup-base-zeroconf \
    packagegroup-distro-base \
    packagegroup-machine-base \
    packagegroup-base-ipv6 \
    os-release \
    htop \
    ca-certificates \
    networkmanager \
    wireguard-tools \
    ${CORE_IMAGE_EXTRA_INSTALL} \
"

IMAGE_INSTALL:append:libc-musl = " gcompat"
# Add pregenerated ssh keys for improving first time bootup speed
IMAGE_INSTALL:append:qemuall = " ssh-pregen-hostkeys"

export IMAGE_BASENAME = "yoe-simple-image"

BAD_RECOMMENDATIONS += "eudev-hwdb udev-hwdb libmodule-build-perl"

# How to add password/user to image
#inherit extrausers

#IMAGE_FEATURES:remove = "allow-empty-password empty-root-password allow-root-login post-install-logging"

#EXTRA_USERS_PARAMS += "\
#    useradd scribbledeedoo; \
#    usermod -p '$(openssl passwd -6 MajorPie5)' scribbledeedoo; \
#    usermod -a -G adm scribbledeedoo; \
#    usermod -a -G video scribbledeedoo; \
#    usermod -a -G audio scribbledeedoo; \
#    usermod -a -G systemd-journal scribbledeedoo; \
#"
#
