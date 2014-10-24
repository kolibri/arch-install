#!/bin/bash
# install core packages

echo "<<< install wget, puppet and base-devel >>>"
pacman -S base-devel --noconfirm
pacman -S wget --noconfirm
pacman -S puppet  --noconfirm
pacman -S git  --noconfirm

# install yaourt
echo "<<< install package-query with makepkg >>>"
wget https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz
tar -xvzf package-query.tar.gz
cd package-query
makepkg -si --noconfirm --asroot

echo "<<< install yaourt with makepkg >>>"
wget https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz
tar -xvzf yaourt.tar.gz
cd yaourt
makepkg -si --noconfirm --asroot

# clone puppet repo
mkdir etc
git clone https://github.com/kolibri/nestbox.git etc/nestbox
