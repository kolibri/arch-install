# install arch

from installation disc:

    curl -O https://raw.githubusercontent.com/kolibri/foo/master/dl_scripts.sh
    source dl_scripts.sh
    # check the scripts!

    ./prepare-hdd.sh
    ./install.sh
    arch-chroot /mnt

via chroot:

    cd /root/
    nano arch-config.sh # edit username/password
    ./arch-config.sh
    exit

from installation disc:

    unmount /mnt
    reboot

