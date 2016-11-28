#!/usr/bin/env bash

curl -O https://raw.githubusercontent.com/kolibri/arch-install/master/arch-config.sh
curl -O https://raw.githubusercontent.com/kolibri/arch-install/master/install.sh
curl -O https://raw.githubusercontent.com/kolibri/arch-install/master/prepare-hdd.sh

curl -O https://raw.githubusercontent.com/kolibri/arch-install/master/arch.conf
curl -O https://raw.githubusercontent.com/kolibri/arch-install/master/loader.conf

chmod +x arch-config.sh
chmod +x install.sh
chmod +x prepare-hdd.sh
