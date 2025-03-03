#!/bin/bash

# Actualizar el sistema
sudo pacman -Syu
yay -Syu

yay -S hyprland-git
yay -S hyprland-meta-git
yay -S ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms libxfixes libx11 libxcomposite libxrender libxcursor pixman wayland-protocols cairo pango libxkbcommon xcb-util-wm xorg-xwayland libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang-git hyprcursor-git hyprwayland-scanner-git xcb-util-errors hyprutils-git glaze hyprgraphics-git aquamarine-git re2 hyprland-qtutils wayland xorg-server xorg-xinit 

# Instalar SDDM
sudo pacman -S sddm qt5-graphicaleffects qt5-svg qt5-quickcontrols2 sddm-wayland qt5-wayland qt6-wayland

# Habilitar SDDM
sudo systemctl enable sddm
sudo systemctl start sddm

# Configurar SDDM para Hyprland
sudo bash -c 'cat > /usr/share/wayland-sessions/hyprland.desktop <<EOF
[Desktop Entry]
Name=Hyprland
Comment=Dynamic tiling Wayland compositor
Exec=Hyprland
Type=Application
DesktopNames=Hyprland
EOF'

# Establecer Hyprland como sesión predeterminada
sudo bash -c 'cat >> /etc/sddm.conf <<EOF
[General]
Session=hyprland.desktop
EOF'

# Personalizar SDDM (Opcional)
yay -S sddm-sugar-candy-git
sudo bash -c 'cat >> /etc/sddm.conf <<EOF
[Theme]
Current=sugar-candy
EOF'

echo "Instalación de Hyprland completada. Puede iniciar Hyprland ejecutando 'Hyprland' desde la terminal."