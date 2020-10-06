# Find vendorId

```bash
udevadm info /sys/class/net/enp0sX | grep -i vendor_id | cut -f2 -d"="
```
(e.g. 18d1 for Google Pixel C)

Set correct `vendorId` in `90-android-tethering.rules`

# Systemd configuration

`50-enp0sX.network`

# Start USB tethering on phone

# Start dhcp
```bash
systemctl start dhcpcd@enp0sX
```

