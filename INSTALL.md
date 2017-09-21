# Verify EFI
```bash
ls /sys/firmware/efi/efivars
```

# Setup Internet access
```bash
wifi-menu
# or
systemctl start dhcpcd@en1
```

# Install polkit
```
pacman -S polkit
```

# Update system clock
```bash
timedatectl set-ntp true
```

# EFI
[EFI System Partition](https://wiki.archlinux.org/index.php/EFI_System_Partition)


# Encryption
See [Encryption](/encryption)
