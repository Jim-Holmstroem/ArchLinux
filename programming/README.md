# Visual Studio Code - OSS Edition
https://wiki.archlinux.org/index.php/Visual_Studio_Code#VS_Live_Share_missing_API

Add the relevant entries to the `extensionAllowedProposedApi` section in the `product.json` file (`code` installs this to `/usr/lib/code/product.json`).

(NOTE. append)
```
"extensionAllowedProposedApi": [
    "ms-vsliveshare.vsliveshare",
    "ms-vscode.node-debug",
    "ms-vscode.node-debug2"
]
```
