# Kernel + Module version missmatch
## Symptoms
```
$ mkinitcpio -p linux
...
ERROR: '/lib/modules/4.13.3-1-ARCH' is not a valid kernel module directory
...
```
Unable to `startx` or start `wifi-menu`.

## What
After a kernel update.

## Solution
Boot live arch linux from USB-stick and enter chroot environment, ensure that the `/boot` is properly mounted, then:
```
pacman -Sy linux --force
```
