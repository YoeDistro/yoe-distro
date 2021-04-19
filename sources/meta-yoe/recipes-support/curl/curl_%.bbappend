FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# We do not want GNUtls or libidn
PACKAGECONFIG_remove_class-target = "gnutls libidn"

# Default SSL backend is mbedtls
PACKAGECONFIG_append_class-target = " mbedtls brotli"
