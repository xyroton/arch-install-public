#!/bin/sh

clear
echo ""
echo " ██████  ██    ██ ██ "
echo "██       ██    ██ ██ "
echo "██   ███ ██    ██ ██ "
echo "██    ██ ██    ██ ██ "
echo " ██████   ██████  ██ "
echo ""

pacman --noconfirm -S xorg xfce4 xfce4-goodies lightdm lightdm-gtk-greeter \
    qtile picom 

systemctl enable lightdm

echo ""
echo "██████   ██████  ███    ██ ███████"
echo "██   ██ ██    ██ ████   ██ ██"
echo "██   ██ ██    ██ ██ ██  ██ █████"
echo "██   ██ ██    ██ ██  ██ ██ ██"
echo "██████   ██████  ██   ████ ███████"
echo ""

echo " Type: 'exit', 'umount -l /mnt', 'poweroff or shutdown now'!"
