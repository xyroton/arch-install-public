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
read -p "Enter the name of the ROOT partition (eg. sda2): " root_part
read -p "Enter the name of the SWAP partition (eg. sda1): " swap_part


# ------------------------------------------------------
# Sync time
# ------------------------------------------------------
timedatectl set-ntp true

# ------------------------------------------------------
# Format partitions
# ------------------------------------------------------
mkfs.ext4 /dev/$root_part
mkswap /dev/$swap_part

# ------------------------------------------------------
# Activate swap
# ------------------------------------------------------
swapon /dev/$swap_part

# ------------------------------------------------------
# Mount points
# ------------------------------------------------------
mount /dev/$root_part /mnt

# ------------------------------------------------------
# Check mount points
# ------------------------------------------------------
lsblk
sleep 5

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
arch-chroot /mnt ./archinstall/2-config.sh
