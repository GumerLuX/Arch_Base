#!/bin/bash

#   ____             __ _                       _   _             
#  / ___|___  _ __  / _(_) __ _ _   _ _ __ __ _| |_(_) ___  _ __  
# | |   / _ \| '_ \| |_| |/ _` | | | | '__/ _` | __| |/ _ \| '_ \ 
# | |__| (_) | | | |  _| | (_| | |_| | | | (_| | |_| | (_) | | | |
#  \____\___/|_| |_|_| |_|\__, |\__,_|_|  \__,_|\__|_|\___/|_| |_|
#                         |___/                                   
# Por SinLuX90 (2025)
# ------------------------------------------------------
clear

keyboardlayout="es"
zoneinfo="Europe/Madrid"
hostname="sinlux90"
username="sindo"

# ------------------------------------------------------
# Establecer la hora del sistema
# ------------------------------------------------------
ln -sf /usr/share/zoneinfo/$zoneinfo /etc/localtime
hwclock --systohc

# ------------------------------------------------------
# Actualizar reflector
# ------------------------------------------------------
echo "Start reflector..."
reflector -c "Germany,France,Spain" -p https -a 3 --sort rate --save /etc/pacman.d/mirrorlist

# ------------------------------------------------------
# Sincronizar mirrors
# ------------------------------------------------------
pacman -Syy

# ------------------------------------------------------
# Instalacion de  Paquetes
# ------------------------------------------------------
pacman --noconfirm -S grub xdg-desktop-portal-wlr efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers avahi xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call dnsmasq openbsd-netcat ipset firewalld flatpak sof-firmware nss-mdns acpid os-prober ntfs-3g terminus-font exa bat htop ranger zip unzip neofetch duf xorg xorg-xinit xclip grub-btrfs xf86-video-amdgpu xf86-video-nouveau xf86-video-intel xf86-video-qxl brightnessctl pacman-contrib inxi

# ------------------------------------------------------
# Establecer el idioma utf8 es
# ------------------------------------------------------
echo "es_ES.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=es_ES.UTF-8" >> /etc/locale.conf

# ------------------------------------------------------
# Establecer contraseña de root
# ------------------------------------------------------
echo "Set root password"
passwd root

# ------------------------------------------------------
# Añadir uduario
# ------------------------------------------------------
echo "Add user $username"
useradd -m -G wheel $username
passwd $username

# ------------------------------------------------------
# Habilitar servicios
# ------------------------------------------------------
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable avahi-daemon
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable firewalld
systemctl enable acpid

# ------------------------------------------------------
# Grub instalacion
# ------------------------------------------------------
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --removable
grub-mkconfig -o /boot/grub/grub.cfg

# ------------------------------------------------------
# Agregemos btrfs y setfont a mkinitcpio
# ------------------------------------------------------
# Before: BINARIES=()
# After:  BINARIES=(btrfs setfont)
sed -i 's/BINARIES=()/BINARIES=(btrfs setfont)/g' /etc/mkinitcpio.conf
mkinitcpio -p linux

# ------------------------------------------------------
# Agregamos usuario a el grupo 'wheel'
# ------------------------------------------------------
clear
echo "Uncomment %wheel group in sudoers (around line 85):"
echo "Before: #%wheel ALL=(ALL:ALL) ALL"
echo "After:  %wheel ALL=(ALL:ALL) ALL"
echo ""
read -p "Open sudoers now?" c
EDITOR=vim sudo -E visudo
usermod -aG wheel $username

# ------------------------------------------------------
# Copiamos los scripts de instalacion el directorio home 
# ------------------------------------------------------
cp /archinstall/3-yay.sh /home/$username
cp /archinstall/4-zram.sh /home/$username
cp /archinstall/5-timeshift.sh /home/$username
cp /archinstall/6-preload.sh /home/$username
cp /archinstall/snapshot.sh /home/$username

clear
echo "     _                   "
echo "  __| | ___  _ __   ___  "
echo " / _' |/ _ \| '_ \ / _ \ "
echo "| (_| | (_) | | | |  __/ "
echo " \__,_|\___/|_| |_|\___| "
echo "                         "
echo ""
echo "Instalacion adicional de scripts en su directorio home:"
echo "- yay AUR helper: 3-yay.sh"
echo "- zram swap: 4-zram.sh"
echo "- Herramienta de instantanea timeshift: 5-timeshift.sh"
echo "- preload aplicacion de cache: 6-preload.sh"
echo "- Aplicacion de instantanea: snapshot.sh"
echo ""
echo "Escriva: exit & shutdown (shutdown -h now) para apagar la computadora,retire el medio de instalacion y empiece de nuevo."
echo "Importante: active el WIFE despues de reiniciar con 'nmtui'."




