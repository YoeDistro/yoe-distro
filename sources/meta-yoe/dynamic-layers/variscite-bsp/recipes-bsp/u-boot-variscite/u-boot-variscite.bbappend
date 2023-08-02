FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:yoe:imx8mn-var-som = "\
    file://0001-move-fdt-load-up-to-make-space-for-kernel.patch \
    file://0001-imx8mn_var_som-Adjust-for-boot-root-data-paritioning.patch \
"

SRC_URI:append:yoe:imx8qxp-var-som = "\
    file://0001-imx8qxp_var_som-Adjust-for-boot-root-data-paritioning.patch \
"

SRC_URI:append:yoe:imx8qm-var-som = "\
    file://0001-imx8qm_var_som-Adjust-for-boot-root-data-paritioning.patch \
"

SRC_URI += "file://nologo.cfg"
