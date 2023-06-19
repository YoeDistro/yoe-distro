FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://wireguard.cfg \
            file://updater.cfg \
            file://extra.cfg \
            file://overlayfs.cfg \
           "

KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/wireguard.cfg \
                            ${WORKDIR}/updater.cfg \
                            ${WORKDIR}/extra.cfg \
                            ${WORKDIR}/overlayfs.cfg \
                           "
