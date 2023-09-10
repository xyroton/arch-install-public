# arch-install-public
> Simple stuff to speed the arch install up a little.

## Steps to follow:
```
# Load keyboard layout 
loadkeys de-latin1
```

1. Check connection
```
ping google.com
```

2. Check if BIOS or UEFI (if you get output that means you are of UEFI else BIOS)
```
ls /sys/firmware/efi/efivars # check if uefi mode is enabled
```

# Check partitions
```
lsblk
```

# Create partitions
```
fdsk /dev/sda

# create root partition
o # wipe the drive as if brand new
n # create new partition
w # to write
```

# Sync package
```
pacman -Syy
```

# Update keyring just in case
```
pacman -S archlinux-keyring
pacman -Syy
```

# Install git
```
pacman -S git
```

# Clone the repo
```
git clone https://github.com/xyroton/arch-install-public
```

# Run the install script
```
./1-install.sh
```

```
