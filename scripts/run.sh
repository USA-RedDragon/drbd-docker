#!/bin/bash

set -x

if [ "$PROBE" = "true" ]; then
    modprobe drbb
    modprobe drbd_transport_tcp
fi 

# Turn on error exiting
set -e

if [[ ! -e /sys/module/drbd ]] || [[ ! -e /sys/module/drbd_transport_tcp ]]; then
    # Install drbd. This has to be done dynamically since the kernel
    # module depends on the host kernel version.
    apt-get update -y
    apt-get install -y --no-install-recommends linux-headers-$(uname -r)
    apt-get install -y --no-install-recommends drbd-dkms

    rm -rf /var/lib/apt/lists/*

    modprobe drbd
    modprobe drbd_transport_tcp
fi

# Return code is whether module is loaded
[ -e /sys/module/drbd ] || exit 1
[ -e /sys/module/drbd_transport_tcp ] || exit 1

exit 0
