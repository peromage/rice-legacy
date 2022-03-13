#!/bin/sh

## This script must be executed in a archiso environment
## Notice: Make sure disks are partitioned and root partition is mounted under
## archiso's /mnt/

BASE_PACKAGES="base linux linux-firmware intel-ucode"

pacstrap /mnt $BASE_PACKAGES
