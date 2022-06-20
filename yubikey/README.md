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


## AWS
register
```
ykman oath accounts add -t  arn:aws:iam::<account-id>:user/<user>
```

get key
```
ykman oath accounts code  arn:aws:iam::<account-id>:user/<user>
```
