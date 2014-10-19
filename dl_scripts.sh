#!/usr/bin/env bash

curl -O https://raw.githubusercontent.com/kolibri/foo/master/arch-config.sh
curl -O https://raw.githubusercontent.com/kolibri/foo/master/init_utils.sh
curl -O https://raw.githubusercontent.com/kolibri/foo/master/install.sh
curl -O https://raw.githubusercontent.com/kolibri/foo/master/prepare-hdd.sh

curl -O https://raw.githubusercontent.com/kolibri/foo/master/arch.conf
curl -O https://raw.githubusercontent.com/kolibri/foo/master/loader.conf

chmod +x arch-config.sh
chmod +x init_utils.sh
chmod +x install.sh
chmod +x prepare-hdd.sh
