#!/bin/bash
# __   __ _ __   __
# \ \ / // \\ \ / /
#  \ V // _ \\ V / 
#   | |/ ___ \| |  
#   |_/_/   \_\_|  
#                 
# Por SinLuX90 (2025)
# ------------------------------------------------------
# Instalacion Script de Yay
# ------------------------------------------------------
# Name: yay Install Script
# DESC: Todos los pasos necesarios para instalar yay
# WARNING: Ejecute este script bajo su propia responsabilidad.

clear
echo "__   __ _ __   __"
echo "\ \ / // \\ \ / /"
echo " \ V // _ \\ V / "
echo "  | |/ ___ \| |  "
echo "  |_/_/   \_\_|  "
echo "                 "
echo ""

# -----------------------------------------------------
# Confirmar inicio
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
cd /tmp
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
makepkg -si
cd ~/

echo "HECHO!"
