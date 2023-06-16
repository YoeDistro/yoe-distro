FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:yoe = "\
    file://0001-imx8qm_var_som-Adjust-for-boot-root-data-paritioning.patch \
    file://0001-imx8qxp_var_som-Adjust-for-boot-root-data-paritioning.patch \
    file://0001-imx8mn_var_som-Adjust-for-boot-root-data-paritioning.patch \
"
