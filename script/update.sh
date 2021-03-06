#!/bin/bash -eux
if [[ $UPDATE  =~ true || $UPDATE =~ 1 || $UPDATE =~ yes ]]; then
    echo "==> Applying updates"
    dnf -y update

    # reboot
    echo "Rebooting the machine..."
    reboot
fi
