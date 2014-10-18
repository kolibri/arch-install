#!/usr/bin/env bash

CONFIG_SCRIPT='arch-config.sh'
TARGET_DIR='/mnt'

echo " \\\\(^)> INSTALL ARCH START <(^)//"

echo '==> bootstrapping the base installation'
#pacstrap /mnt base base-devel wpa_supplicant
/usr/bin/pacstrap ${TARGET_DIR} base # base-devel

echo '==> generating the filesystem table'
/usr/bin/genfstab -p ${TARGET_DIR} >> "${TARGET_DIR}/etc/fstab"

echo "next: arch-chroot ${TARGET_DIR} ${CONFIG_SCRIPT}"
echo "next: unmount ${TARGET_DIR}"
echo "next: systemctl reboot"
