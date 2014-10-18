#!/usr/bin/env bash

loadkeys de

/usr/bin/sgdisk --zap ${DISK}

echo "-- set partition positions"
/usr/bin/sgdisk --new=1:0:0 /dev/sda

echo "-- set partition names"
/usr/bin/sgdisk --change-name 1:home /dev/sda

echo "-- set partition types"
/usr/bin/sgdisk --typecode=1:8300 /dev/sda

/usr/bin/mkfs.ext3 /dev/sda1
/usr/bin/mount  /dev/sda1 /mnt
