#!/usr/bin/env bash

loadkeys de

/usr/bin/sgdisk --zap ${DISK}

echo "-- set partition positions"
/usr/bin/sgdisk --new=1:0:512M /dev/sda
/usr/bin/sgdisk --new=2:0:0 /dev/sda

echo "-- set partition names"
/usr/bin/sgdisk --change-name 1:boot /dev/sda
/usr/bin/sgdisk --change-name 2:home /dev/sda

echo "-- set partition types"
/usr/bin/sgdisk --typecode=1:ef00 /dev/sda
/usr/bin/sgdisk --typecode=2:8300 /dev/sda

echo "-- format partitions"
mkfs.fat -F32 /dev/sda1
/usr/bin/mkfs.ext3 /dev/sda2
/usr/bin/mount  /dev/sda2 /mnt
