Use the `other` systems (E.g. Windows/MacOS) EFI System as `/boot`, do not create your own.
Mount the `other` systems EFI System under `/boot` and continue to install EFI GRUB.


```
sudo grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot
sudo grub-mkconfig -o /boot/grub/grub.cfg
```