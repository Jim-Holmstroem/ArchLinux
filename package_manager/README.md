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
