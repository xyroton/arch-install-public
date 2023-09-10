#!/bin/sh

clear
echo ""
echo " ██████  ██████  ███    ██ ███████ ██  ██████  "
echo "██      ██    ██ ████   ██ ██      ██ ██        "
echo "██      ██    ██ ██ ██  ██ █████   ██ ██   ███  "
echo "██      ██    ██ ██  ██ ██ ██      ██ ██    ██  "
echo " ██████  ██████  ██   ████ ██      ██  ██████   "
echo "------------------------------------------------------"

# ------------------------------------------------------
# Take input
# ------------------------------------------------------
read -p "Enter the desired username: " username
echo "------------------------------------------------------"
read -s -p "Enter the password for 'root' and '$username': " password
echo ""
read -s -p "Confirm the password: " password_confirm
echo ""
echo "------------------------------------------------------"

# ------------------------------------------------------
# Check if the passwords match
# ------------------------------------------------------
if [ "$password" != "$password_confirm" ]; then
    echo ""
    echo "Passwords do not match. Please run the script again."
    exit 1
fi

# ------------------------------------------------------
# Set basics
# ------------------------------------------------------
keyboardlayout="de-latin1"
zoneinfo="Europe/Berlin"
country="Germany"
hostname="archlinux"

# ------------------------------------------------------
# Set System Time
# ------------------------------------------------------
ln -sf /usr/share/zoneinfo/$zoneinfo /etc/localtime
hwclock --systohc


# ------------------------------------------------------
# Set locals
# ------------------------------------------------------
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# ------------------------------------------------------
# Set Keyboard
# ------------------------------------------------------
echo "KEYMAP=$keyboardlayout" >> /etc/vconsole.conf

# ------------------------------------------------------
# Update reflector
# ------------------------------------------------------
echo "Start reflector..."
reflector -c $country -p https -a 3 --sort rate --save /etc/pacman.d/mirrorlist

# ------------------------------------------------------
# Synchronize mirrors
# ------------------------------------------------------
pacman -Syy

# ------------------------------------------------------
# Install Packages
# ------------------------------------------------------
pacman --noconfirm -S grub xdg-desktop-portal-wlr efibootmgr networkmanager \
  network-manager-applet dialog wpa_supplicant mtools dosfstools \
  base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs \
  gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip \
  alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack \
  bash-completion openssh rsync reflector acpi acpi_call dnsmasq \
  openbsd-netcat ipset firewalld flatpak sof-firmware nss-mdns acpid \
  os-prober ntfs-3g terminus-font exa bat htop zip unzip \
  neofetch duf xorg xorg-xinit xclip grub-btrfs intel-ucode \
  xf86-video-nouveau xf86-video-intel xf86-video-qxl \
  pacman-contrib inxi man


# ------------------------------------------------------
# Set hostname and localhost
# ------------------------------------------------------
echo "$hostname" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 $hostname.localdomain $hostname" >> /etc/hosts

echo "root:$password" | chpasswd
clear

# ------------------------------------------------------
# set up grub
# ------------------------------------------------------
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# ------------------------------------------------------
# add user
# ------------------------------------------------------
useradd -m $username
echo "$username:$password" | chpasswd

echo "$username ALL=(ALL) ALL" >> /etc/sudoers.d/$username

# ------------------------------------------------------
# Enable Services
# ------------------------------------------------------
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid

# ------------------------------------------------------
# Finished
# ------------------------------------------------------
clear
echo ""
echo "███████ ██ ███    ██ ██ ███████ ██   ██ ███████ ██████  "
echo "██      ██ ████   ██ ██ ██      ██   ██ ██      ██   ██ "
echo "█████   ██ ██ ██  ██ ██ ███████ ███████ █████   ██   ██ "
echo "██      ██ ██  ██ ██ ██      ██ ██   ██ ██      ██   ██ "
echo "██      ██ ██   ████ ██ ███████ ██   ██ ███████ ██████  "
echo ""

echo " Type: 'exit', 'umount -a', 'poweroff'!"
echo ""
echo "Next run the above options or run the next scipt!"
