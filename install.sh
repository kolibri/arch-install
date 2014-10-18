#!/usr/bin/env bash
FQDN='user.ko'
KEYMAP='de'
LANGUAGE='en_US.UTF-8'
USER_NAME='user'
USER_PASSWORD=$(/usr/bin/openssl passwd -crypt 'user')
ROOT_PASSWORD=$(/usr/bin/openssl passwd -crypt 'root')
TIMEZONE='UTC+1'

CONFIG_SCRIPT='/usr/local/bin/arch-config.sh'
TARGET_DIR='/mnt'

echo " \\\\(^)> INSTALL ARCH START <(^)//"

echo '==> bootstrapping the base installation'
/usr/bin/pacstrap ${TARGET_DIR} base base-devel

echo '==> generating the filesystem table'
/usr/bin/genfstab -p ${TARGET_DIR} >> "${TARGET_DIR}/etc/fstab"

echo '==> generating the system configuration script'
/usr/bin/install --mode=0755 /dev/null "${TARGET_DIR}${CONFIG_SCRIPT}"

cat <<-EOF > "${TARGET_DIR}${CONFIG_SCRIPT}"
echo '${FQDN}' > /etc/hostname
/usr/bin/ln -s /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo 'KEYMAP=${KEYMAP}' > /etc/vconsole.conf
/usr/bin/sed -i 's/#${LANGUAGE}/${LANGUAGE}/' /etc/locale.gen
/usr/bin/locale-gen
/usr/bin/mkinitcpio -p linux
/usr/bin/usermod --password ${ROOT_PASSWORD} root
# https://wiki.archlinux.org/index.php/Network_Configuration#Device_names
/usr/bin/ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
/usr/bin/ln -s '/usr/lib/systemd/system/dhcpcd@.service' '/etc/systemd/system/multi-user.target.wants/dhcpcd@eth0.service'
#/usr/bin/sed -i 's/#UseDNS yes/UseDNS no/' /etc/ssh/sshd_config
#/usr/bin/systemctl enable sshd.service

# admin-specific configuration
/usr/bin/groupadd ${USER_NAME}
/usr/bin/useradd --password ${USER_PASSWORD} --comment 'admin User' --create-home --gid users --groups ${USER_NAME} ${USER_NAME}
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_${USER_NAME}
echo '${USER_NAME} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_${USER_NAME}
/usr/bin/chmod 0440 /etc/sudoers.d/10_${USER_NAME}
/usr/bin/mkdir -p /home/${USER_NAME}/.ssh

# clean up
/usr/bin/pacman -Rcns --noconfirm gptfdisk
/usr/bin/pacman -Scc --noconfirm
EOF

echo '==> entering chroot and configuring system'
/usr/bin/arch-chroot ${TARGET_DIR} ${CONFIG_SCRIPT}
rm "${TARGET_DIR}${CONFIG_SCRIPT}"

echo '==> installation complete!'
/usr/bin/sleep 3
#/usr/bin/umount ${TARGET_DIR}

echo "manual task: unmount ${TARGET_DIR}"
echo "manual task: systemctl reboot"
