#!/bin/bash
#  ____                        _           _    
# / ___| _ __   __ _ _ __  ___| |__   ___ | |_  
# \___ \| '_ \ / _` | '_ \/ __| '_ \ / _ \| __| 
#  ___) | | | | (_| | |_) \__ \ | | | (_) | |_  
# |____/|_| |_|\__,_| .__/|___/_| |_|\___/ \__| 
#                   |_|                         
#  
# Por SinLuX90 (2025)
# ----------------------------------------------------- 

read -p "Introdusca un comentario para la instantanea: " c
sudo timeshift --create --comments "$c"
sudo timeshift --list
sudo grub-mkconfig -o /boot/grub/grub.cfg
echo "HECHO. Instantanea $c Creada!"
