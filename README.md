# arch-install-public
> Simple stuff to speed the arch install up a little.

## Base steps to follow:
1. Load keyboard layout 
```
loadkeys de-latin1
```

2. Check connection
```
ping google.com
```

3. Check if BIOS or UEFI (if you get output that means you are of UEFI else BIOS)
```
ls /sys/firmware/efi/efivars # check if uefi mode is enabled
```

4. Check partitions
```
lsblk
```

5. Create partitions
```
fdsk /dev/sda

# create root partition
o # wipe the drive as if brand new
n # create new partition
w # to write
```

6. Sync package
```
pacman -Syy
```

7. Update keyring just in case
```
pacman -S archlinux-keyring
pacman -Syy
```

8. Install git
```
pacman -S git
```

9. Clone the repo
```
git clone https://github.com/xyroton/arch-install-public
```

10. Run the install script
```
./1-install.sh
```
## (OPTIONAL) Run the following scipt if you wish to set up a DE(XFCE4) and QTILE
```
./3-guisetup.sh
```
## Final Part
Exit, unmount and poweroff
```
exit
umount -a # or umount -l /mnt
poweroff
```


