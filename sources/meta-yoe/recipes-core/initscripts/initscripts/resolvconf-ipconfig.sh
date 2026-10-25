#!/bin/sh
#
# SPDX-License-Identifier: MIT
#

### BEGIN INIT INFO
# Provides:             resolvconf-ipconfig
# Required-Start:       $local_fs
# Required-Stop:
# Default-Start:        S
# Default-Stop:
# Short-Description:    Seed resolv.conf from kernel IP autoconfiguration
### END INIT INFO

# When the network is configured by the kernel (ip= on the command line,
# e.g. qemu or nfsroot), nothing writes the DNS servers it got into
# /etc/resolv.conf, which populate-volatile.sh leaves as an empty file in
# /var/run. Copy them from /proc/net/pnp, unless something already filled
# resolv.conf. A DHCP client started later can still replace the file.

case "$1" in
start)
	[ -s /etc/resolv.conf ] && exit 0
	[ -r /proc/net/pnp ] || exit 0
	grep -qE '^nameserver[[:space:]]+[^[:space:]]' /proc/net/pnp || exit 0
	grep -E '^(domain|search|nameserver)[[:space:]]' /proc/net/pnp > /etc/resolv.conf
	;;
stop|restart|reload|force-reload)
	;;
*)
	echo "Usage: $0 start" >&2
	exit 1
	;;
esac

exit 0
