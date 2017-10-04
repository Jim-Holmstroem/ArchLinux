# Kernel + Module version missmatch
## Symptoms
```
$ mkinitcpio -p linux
...
ERROR: '/lib/modules/4.13.3-1-ARCH' is not a valid kernel module directory
...
```
Unable to `startx` or start `wifi-menu`.

## After
After a kernel update.

## Solution
Boot live arch linux from USB-stick and enter chroot environment, ensure that the `/boot` is properly mounted, then:
```
pacman -Sy linux --force
```

# Command not found: javadoc after java version change
## Symptoms
```
$ javadoc
...
command not found: javadoc
```
## After
Changed between `java7` and `java8`.

## Solution
Reinstalling java
```
sudo pacman -S j{re,dk}8-openjdk
```
