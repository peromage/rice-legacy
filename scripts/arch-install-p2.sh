#!/bin/sh

## This script must be executed in a arch-chroot environment!

## Some config variables
MY_NAME=fang
MY_UID=1234
MY_HOSTNAME=ARCHMAGE
# From timedatectl list-timezones
MY_TIMEZONE=America/Detroit

## Package list
SYS_PACKAGES="
sudo
iw
iwd
man
grub
efibootmgr
pulseaudio
pulseaudio-alsa
pavucontrol
"

DE_PACKAGES="
xorg
xfce4
xfce4-goodies
"

DEV_PACKAGES="
cmake
base-devel
"

FONT_PACKAGES="
adobe-source-han-sans-cn-fonts
adobe-source-han-serif-cn-fonts
otf-cascadia-code
ttc-iosevka
"

MY_PACKAGES="
git
vim
emacs
tmux
openssh
bash
bash-completion
firefox
fcitx-im
fcitx-configtool
fcitx-cloudpinyin
fcitx-sunpinyin
"

echo $SYS_PACKAGES $DE_PACKAGES $DEV_PACKAGES $FONT_PACKAGES $MY_PACKAGES
exit
## Begin setup
echo "## Syncing package..."
pacman -Syy
pacman -S $SYS_PACKAGES $DE_PACKAGES $DEV_PACKAGES $FONT_PACKAGES $MY_PACKAGES

echo "## Configuring date and time..."
hwclock --systohc
timedatectl set-timezone $MY_TIMEZONE
timedatectl set-ntp true

echo "## Configuring locale..."
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
echo zh_CN.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen

echo "## Configuring hostname..."
echo $MY_HOSTNAME > /etc/hostname


echo "## Configuring logins..."
useradd -m -s /bin/bash -u $MY_UID $MY_NAME
passwd $MY_NAME
passwd root
echo "$MY_NAME ALL=(ALL:ALL) ALL" > /etc/sudoers.d/$MY_NAME

echo "## Configuring system services..."
systemctl enable iwd
systemctl enable systemd-resolved

echo "## Configuring bootloader..."
mkinitcpio -P
grub-install --efi-directory=/boot --boot-directory=/boot --target=x86_64-efi --bootloader-id=$MY_HOSTNAME
grub-mkconfig -o /boot/grub/grub.cfg
