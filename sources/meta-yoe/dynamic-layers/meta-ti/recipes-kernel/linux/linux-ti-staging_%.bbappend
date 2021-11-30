FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://wireguard.cfg \
            file://updater.cfg \
            file://extra.cfg \
           "

KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/wireguard.cfg \
                            ${WORKDIR}/updater.cfg \
                            ${WORKDIR}/extra.cfg \
                           "
