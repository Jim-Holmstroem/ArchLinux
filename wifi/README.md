In restart wifi `iwctl`
```bash
device wlan0  set-property Powered off;
device wlan0  set-property Powered on;
station wlan0 get-networks
station wlan0 scan
```

Often force some type of reset, not sure what it really does, but it works sometimes
```bash
# iw dev wlan0 link
sudo iw dev wlan0 scan
```
