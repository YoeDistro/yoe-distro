FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# We do not want GNUtls or libidn
PACKAGECONFIG:remove:class-target = "gnutls libidn"

# Default SSL backend is mbedtls
PACKAGECONFIG:append:class-target = " mbedtls brotli"
