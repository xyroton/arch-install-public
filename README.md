# arch-install-public
> Simple stuff to speed the arch install up a little.

## Steps to follow:
```
# Load keyboard layout 
loadkeys de-latin1

# Check connection
ping google.com

# Check if BIOS or UEFI (if you get output that means you are of UEFI else BIOS)
ls /sys/firmware/efi/efivars # check if uefi mode is enabled

# Check partitions
lsblk

# Create partitions
fdisk /dev/sda

# create root partition
o # wipe the drive as if brand new
n # create new partition


```
