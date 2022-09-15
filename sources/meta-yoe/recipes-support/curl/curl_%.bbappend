FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# We do not want GnuTLS,OpensSL,NSS SSL backends or libidn
PACKAGECONFIG:remove:class-target = "gnutls libidn mbedtls nss"

# Default SSL backend is openssl also can be set with
# --with-default-ssl-backend=openssl if say mbedtls is enabled because
# then emedtls becomes default ssl backend otherwise
PACKAGECONFIG:append:class-target = " openssl brotli"
