#!/bin/bash

yay -S hyprland dolphin wofi hyprpaper alacritty firefox 
echo 'cat >> ~/starthypr.sh <<EOF
#!/bin/sh
export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
exec Hyprland
EOF'
chmod +x ~/starthypr.sh
nano .config/hypr/hyprland.conf
./starthypr.sh