# Yubikey

## Install
```
sudo pacman -S \
    yubico-pam \
    yubikey-{manager,personalization} \
    acsccid

systemctl enable pcscd
systemctl start pcscd
systemctl status pcscd
```

## Verify
```
ykman mode
```
