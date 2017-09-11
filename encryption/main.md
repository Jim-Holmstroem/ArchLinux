
```
jim@jim-ws> lsblk -f                                                                                                                                                                         
NAME              FSTYPE      LABEL    UUID                                   MOUNTPOINT
sda
├─sda1            vfat                 XYZW-XYZW                              /boot
└─sda2            crypto_LUKS          01234567-89ab-cdef-0123-456789abcde0
  └─Volume        LVM2_member          012345-6789-AbCd-EfGh-IjKl-MnOp-QrStUv
    ├─Volume-swap swap                 01234567-89ab-cdef-0123-456789abcde1   [SWAP]
    └─Volume-root ext4                 01234567-89ab-cdef-0123-456789abcde2   /
```
