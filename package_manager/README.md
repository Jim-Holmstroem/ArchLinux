# [multilib]
Uncomment `[multilib]` and the following `Include=..` line to enable 32bit buildtools.

# yaourt
```
(
cd ~
    mkdir -p Packages
    (
        cd Packages
        git clone https://aur.archlinux.org/package-query.git
        (
            cd package-query
            makepkg -si
        )
        git clone https://aur.archlinux.org/yaourt.git
        (
            cd yaourt
            makepkg -si
        )
    )
)
```

# automatically update pacman mirrorlist regularly
If you don't keep it up to date, repos can fall out of sync, which means your system will be out of sync. The database sync will be done with the first entry.
Had an instance where the lysator.liu.se thought the latest intel-ucode package actually wheren't the latest, but it was still thought it was synced (hence the exclusion)

```bash
sudo reflector --latest 4 --protocol https --country Sweden,Denmark,Finland,Norway --exclude ".lysator.liu.se" --sort rate --save /etc/pacman.d/mirrorlist
```

This can be set up with automation <https://wiki.archlinux.org/index.php/reflector>
