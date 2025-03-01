#!/bin/bash
#  _  ____     ____  __  
# | |/ /\ \   / /  \/  | 
# | ' /  \ \ / /| |\/| | 
# | . \   \ V / | |  | | 
# |_|\_\   \_/  |_|  |_| 
#                        
#  
# Por SinLuX90 (2025) 
# ----------------------------------------------------- 

# ------------------------------------------------------
# Install Script para Libvirt
# ------------------------------------------------------

read -p "Quieres empezar? " s
echo "INICIAR INSTALACION DE KVM/QEMU/VIRT MANAGER ..."

# ------------------------------------------------------
# Install Packages
# ------------------------------------------------------
sudo pacman -S virt-manager virt-viewer qemu vde2 ebtables iptables-nft nftables dnsmasq bridge-utils ovmf swtpm

# ------------------------------------------------------
# Editar libvirtd.conf
# ------------------------------------------------------
echo "Pasos Manuales requeridos:"
echo "Abrir sudo vim /etc/libvirt/libvirtd.conf:"
echo 'Eliminar # en las siguientes linias: unix_sock_group = "libvirt" y unix_sock_rw_perms = "0770"'
read -p "Presione cualquier tecla para abrir libvirtd.conf: " c
sudo vim /etc/libvirt/libvirtd.conf
sudo echo 'log_filters="3:qemu 1:libvirt"' >> /etc/libvirt/libvirtd.conf
sudo echo 'log_outputs="2:file:/var/log/libvirt/libvirtd.log"' >> /etc/libvirt/libvirtd.conf

# ------------------------------------------------------
# Agregar usuario a group
# ------------------------------------------------------
sudo usermod -a -G kvm,libvirt $(whoami)

# ------------------------------------------------------
# Permitir services
# ------------------------------------------------------
sudo systemctl enable libvirtd
sudo systemctl start libvirtd

# ------------------------------------------------------
# Editar qemu.conf
# ------------------------------------------------------
echo "Pasos Manuales requeridos:"
echo "Abrir sudo vim /etc/libvirt/qemu.conf"
echo "Descomentar y agregar su usuario a group."
echo 'user = "your username"'
echo 'group = "your username"'
read -p "Presione cualquier tecla para abrir qemu.conf: " c
sudo vim /etc/libvirt/qemu.conf

# ------------------------------------------------------
# Reanudar Services
# ------------------------------------------------------
sudo systemctl restart libvirtd

# ------------------------------------------------------
# Red de inicio automatico
# ------------------------------------------------------
sudo virsh net-autostart default

echo "Reinicie el sistema con reboot."
