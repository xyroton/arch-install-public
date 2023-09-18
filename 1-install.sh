!#/bin/sh

clear
echo ""
echo " █████  ██████   ██████ ██   ██ ██ ███    ██ ███████ ████████  █████  ██      ██      "
echo "██   ██ ██   ██ ██      ██   ██ ██ ████   ██ ██         ██    ██   ██ ██      ██      "
echo "███████ ██████  ██      ███████ ██ ██ ██  ██ ███████    ██    ███████ ██      ██      "
echo "██   ██ ██   ██ ██      ██   ██ ██ ██  ██ ██      ██    ██    ██   ██ ██      ██      "
echo "██   ██ ██   ██  ██████ ██   ██ ██ ██   ████ ███████    ██    ██   ██ ███████ ███████ "
echo ""


# ------------------------------------------------------
# Enter partition names
# ------------------------------------------------------
lsblk
read -p "Enter the name of the ROOT partition (eg. sda1): " sda1


# ------------------------------------------------------
# Sync time
# ------------------------------------------------------
timedatectl set-ntp true


# ------------------------------------------------------
# Format partitions
# ------------------------------------------------------
mkfs.ext4 /dev/sda1

# ------------------------------------------------------
# Mount points
# ------------------------------------------------------
mount /dev/sda1 /mnt

# ------------------------------------------------------
# Install base packages
# ------------------------------------------------------
pacstrap -K /mnt base base-devel git linux linux-headers \
  linux-lts linux-lts-headers linux-firmware vim openssh \
  reflector rsync intel-ucode

# ------------------------------------------------------
# Generate fstab
# ------------------------------------------------------
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

# ------------------------------------------------------
# Install configuration scripts
# ------------------------------------------------------
mkdir /mnt/archinstall
cp 2-config.sh /mnt/archinstall/
cp 3-guisetup.sh /mnt/archinstall/

# ------------------------------------------------------
# Chroot to installed sytem
# ------------------------------------------------------
arch-chroot /mnt
echo "run the 2-configl.sh script now"
