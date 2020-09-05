IMAGE_FEATURES += "empty-root-password allow-empty-password"

IMAGE_PREPROCESS_COMMAND += "do_systemd_network ; "

do_systemd_network () {
        install -d ${IMAGE_ROOTFS}${sysconfdir}/systemd/network
        cat << EOF > ${IMAGE_ROOTFS}${sysconfdir}/systemd/network/10-en.network
[Match]
Name=en*

[Network]
DHCP=yes

[DHCP]
RouteMetric=10
ClientIdentifier=mac
EOF

        cat << EOF > ${IMAGE_ROOTFS}${sysconfdir}/systemd/network/11-eth.network
[Match]
Name=eth*

[Network]
DHCP=yes

[DHCP]
RouteMetric=10
ClientIdentifier=mac
EOF

        cat << EOF > ${IMAGE_ROOTFS}${sysconfdir}/systemd/network/12-wl.network
[Match]
Name=wl*

[Network]
DHCP=yes

[DHCP]
RouteMetric=20
ClientIdentifier=mac
EOF

}
