FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://wireguard.cfg \
            file://updater.cfg \
           "

KERNEL_CONFIG_FRAGMENTS += "${WORKDIR}/wireguard.cfg \
                            ${WORKDIR}/updater.cfg \
                           "
