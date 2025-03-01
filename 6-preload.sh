#!/bin/bash
#  ____           _                 _  
# |  _ \ _ __ ___| | ___   __ _  __| | 
# | |_) | '__/ _ \ |/ _ \ / _` |/ _` | 
# |  __/| | |  __/ | (_) | (_| | (_| | 
# |_|   |_|  \___|_|\___/ \__,_|\__,_| 
#                                      
# Por SinLuX90 (2025) 
# ----------------------------------------------------- 
# Preload Install Script
# yay must be installed
# -----------------------------------------------------
# NAME: Preload Instalacion
# DESC: Instalacion script para preload
# WARNING: Ejecute este script bajo su propia responsabilidad.

clear
echo " ____           _                 _  "
echo "|  _ \ _ __ ___| | ___   __ _  __| | "
echo "| |_) | '__/ _ \ |/ _ \ / _' |/ _' | "
echo "|  __/| | |  __/ | (_) | (_| | (_| | "
echo "|_|   |_|  \___|_|\___/ \__,_|\__,_| "
echo "                                      "
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
# Instalacion zram
# -----------------------------------------------------
yay --noconfirm -S preload

echo "HECHO!"
