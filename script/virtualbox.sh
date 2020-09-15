#!/bin/bash -eux

SSH_USER=${SSH_USERNAME:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}

if [[ $PACKER_BUILDER_TYPE =~ virtualbox ]]; then
    echo "==> Installing VirtualBox guest additions"
    # Need to set the KERN_DIR in Fedora 26/27/28/29/30/31/32 or the VBox additions will not install
    # Version specific is not needed anymore ?
    python -mplatform | grep -qi "fedora-32" && echo "Fedora 32 detected" && \
        KERN_DIR=/lib/modules/"$(uname -r)"/build && export KERN_DIR
    if [ "x$KERN_DIR" != "x" ]; then
        # Some of these packages should already have been installed in the kickstart
        dnf -y install kernel-headers-"$(uname -r)" kernel-devel-"$(uname -r)" gcc make perl dkms
        VBOX_VERSION=$(cat $SSH_USER_HOME/.vbox_version)
        mount -o loop $SSH_USER_HOME/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
        sh /mnt/VBoxLinuxAdditions.run --nox11
        umount /mnt
    else
        echo "Canceling installation of VirtualBox guest additions"
    fi
    rm -rf $SSH_USER_HOME/VBoxGuestAdditions_$VBOX_VERSION.iso
    rm -f $SSH_USER_HOME/.vbox_version
fi
