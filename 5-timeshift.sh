#!/bin/bash
#  _____ _                     _     _  __ _    
# |_   _(_)_ __ ___   ___  ___| |__ (_)/ _| |_  
#   | | | | '_ ` _ \ / _ \/ __| '_ \| | |_| __| 
#   | | | | | | | | |  __/\__ \ | | | |  _| |_  
#   |_| |_|_| |_| |_|\___||___/_| |_|_|_|  \__| 
#                                               
#  
# Por SinLuX90 (2025)
# ----------------------------------------------------- 
# Instalacion Timeshift Script
# Tiene que estar instalado
# -----------------------------------------------------
# NAME: Timeshift Installacion
# DESC: Installacion del script para timeshift
# WARNING: Ejecute este script bajo su propia responsabilidad.

clear
echo " _____ _                     _     _  __ _    "
echo "|_   _(_)_ __ ___   ___  ___| |__ (_)/ _| |_  "
echo "  | | | | '_ ' _ \ / _ \/ __| '_ \| | |_| __| "
echo "  | | | | | | | | |  __/\__ \ | | | |  _| |_  "
echo "  |_| |_|_| |_| |_|\___||___/_| |_|_|_|  \__| "
echo "                                               "
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

# -----------------------------------------------------
# Instalacion zram
# -----------------------------------------------------
yay --noconfirm -S timeshift

echo "HECHO!"
echo "Pueded crear instantaneas y actualizar el gestor de arranqur GRUB con ./snapshot.sh"

