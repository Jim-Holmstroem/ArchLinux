# Encryption
"The straight-forward method is to set up LVM on top of the encrypted partition instead of the other way round."
Have LVM on LUKS
[Encrypting an entire system](https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS)

* Name `cryptolvm` to `System` instead, make it more consistent.
* Ignore creating `/home` partition and have everything except swap and `/boot` under `/`.


```
GRUB_CMDLINE_LINUX="cryptdevice=UUID=<UUID-of-crypto_LUKS>:System root=/dev/mapper/System-root"
```
Note. the UUID must be the one for the `crypto_LUKS` device and *not* the `System` device (The `System` device is not decrypted yet, so the entrypoint must be the `crypto_LUKS` device)


Resulting partition and stuff similar to this:
```
jim@jim-ws> lsblk -f                                                                                                                                                                         
NAME              FSTYPE      LABEL    UUID                                   MOUNTPOINT
sda
├─sda1            vfat                 XYZW-XYZW                              /boot
└─sda2            crypto_LUKS          01234567-89ab-cdef-0123-456789abcde0
  └─System        LVM2_member          012345-6789-AbCd-EfGh-IjKl-MnOp-QrStUv
    ├─System-swap swap                 01234567-89ab-cdef-0123-456789abcde1   [SWAP]
    └─System-root ext4                 01234567-89ab-cdef-0123-456789abcde2   /
```

```
jim@jim-ws> df -h                                                                                                                                                                            
Filesystem               Size  Used Avail Use% Mounted on
dev                      7.8G     0  7.8G   0% /dev
run                      7.8G  964K  7.8G   1% /run
/dev/mapper/System-root  213G   34G  169G  17% /
tmpfs                    7.8G  272K  7.8G   1% /dev/shm
tmpfs                    7.8G     0  7.8G   0% /sys/fs/cgroup
tmpfs                    7.8G  2.0M  7.8G   1% /tmp
/dev/sda1                511M   61M  451M  12% /boot
tmpfs                    1.6G   16K  1.6G   1% /run/user/1000
```

```
jim@jim-ws> cat /proc/swaps                                                                                                                                                                  Filename                                Type            Size    Used    Priority
/dev/dm-1                               partition       16777212        0       -1
```
