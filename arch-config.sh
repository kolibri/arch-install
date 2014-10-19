FQDN='user.ko'
KEYMAP='de'
LANGUAGE='en_US.UTF-8'
USER_NAME='user'
USER_PASSWORD=$(/usr/bin/openssl passwd -crypt 'user')
ROOT_PASSWORD=$(/usr/bin/openssl passwd -crypt 'root')
TIMEZONE='UTC+1'

CONFIG_SCRIPT='arch-config.sh'
TARGET_DIR='/mnt'

echo '${FQDN}' > /etc/hostname
/usr/bin/ln -s /usr/share/zoneinfo/${TIMEZONE} /etc/localtime
echo 'KEYMAP=${KEYMAP}' > /etc/vconsole.conf
/usr/bin/sed -i 's/#${LANGUAGE}/${LANGUAGE}/' /etc/locale.gen
/usr/bin/locale-gen
/usr/bin/mkinitcpio -p linux
/usr/bin/usermod --password ${ROOT_PASSWORD} root

# admin-specific configuration
/usr/bin/groupadd ${USER_NAME}
/usr/bin/useradd --password ${USER_PASSWORD} --comment 'admin User' --create-home --gid users --groups ${USER_NAME} ${USER_NAME}
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_${USER_NAME}
echo '${USER_NAME} ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_${USER_NAME}
/usr/bin/chmod 0440 /etc/sudoers.d/10_${USER_NAME}
/usr/bin/mkdir -p /home/${USER_NAME}/.ssh

/usr/bin/pacman -S gummiboot --noconfirm
gummiboot --path=/boot install

/usr/bin/cp loader.conf /boot/loader/loader.conf
/usr/bin/cp arch.conf /boot/loader/entries/arch.conf

# clean up
/usr/bin/pacman -Rcns --noconfirm gptfdisk
/usr/bin/pacman -Scc --noconfirm
