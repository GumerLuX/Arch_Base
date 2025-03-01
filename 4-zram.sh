#!/bin/bash
#  _________      _    __  __ 
# |__  /  _ \    / \  |  \/  |
#   / /| |_) |  / _ \ | |\/| |
#  / /_|  _ <  / ___ \| |  | |
# /____|_| \_\/_/   \_\_|  |_|
#
# Por SinLuX90 (2025)                            
# -----------------------------------------------------
# Instalacion Script de ZRAM Script
# Tiene que estar instalado
# -----------------------------------------------------
# NAME: ZRAM Instalacion
# DESC: Instalacionn script for zram.
# WARNING: Run this script at your own risk.

clear
echo " _________      _    __  __ "
echo "|__  /  _ \    / \  |  \/  |"
echo "  / /| |_) |  / _ \ | |\/| |"
echo " / /_|  _ <  / ___ \| |  | |"
echo "/____|_| \_\/_/   \_\_|  |_|"
echo ""

# -----------------------------------------------------
# Confirm Start
# -----------------------------------------------------
while true; do
    read -p "¿QUIERES COMENZAR LA INSTALACION AHORA? (Yy/Nn): " yn
    case $yn in
        [Yy]* )
            echo "Comenzar la Instalacion."
        break;;
        [Nn]* ) 
            exit;
        break;;
        * ) echo "Porfavor responda yes o no.";;
    esac
done

# -----------------------------------------------------
# Install zram
# -----------------------------------------------------
yay --noconfirm -S zram-generator

# -----------------------------------------------------
# Open zram-generator.conf
# -----------------------------------------------------
if [ -f "/etc/systemd/zram-generator2.conf" ]; then
    echo "/etc/systemd/zram-generator.conf already exists!"
else
	sudo touch /etc/systemd/zram-generator.conf
	sudo bash -c 'echo "[zram0]" >> /etc/systemd/zram-generator.conf'
	sudo bash -c 'echo "zram-size = ram / 2" >> /etc/systemd/zram-generator.conf'
    sudo systemctl daemon-reload
    sudo systemctl start /dev/zram0
fi

echo "HECHO! Reinicie ahora y verifique con -h la instalacion de ZRAM."