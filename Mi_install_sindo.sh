#!/bin/bash
clear
cfdisk
# ------------------------------------------------------
# Introduce el nombre de lasparticiones
# ------------------------------------------------------
lsblk
read -p "Enter the name of the EFI partition (eg. sda1): " sda1
read -p "Enter the name of the ROOT partition (eg. sda2): " sda2

# ------------------------------------------------------
# Sincronizar la hora de la maquina
# ------------------------------------------------------
timedatectl set-ntp true

# ------------------------------------------------------
# Formatear particiones
# ------------------------------------------------------
mkfs.fat -F 32 /dev/$sda1;
mkfs.btrfs -f /dev/$sda2

# ------------------------------------------------------
# Montar particiones para btrfs
# ------------------------------------------------------
mount /dev/$sda2 /mnt
btrfs su cr /mnt/@
btrfs su cr /mnt/@cache
btrfs su cr /mnt/@home
btrfs su cr /mnt/@snapshots
btrfs su cr /mnt/@log
umount /mnt

mount -o compress=zstd:1,noatime,subvol=@ /dev/$sda2 /mnt
mkdir -p /mnt/{boot/efi,home,.snapshots,var/{cache,log}}
mount -o compress=zstd:1,noatime,subvol=@cache /dev/$sda2 /mnt/var/cache
mount -o compress=zstd:1,noatime,subvol=@home /dev/$sda2 /mnt/home
mount -o compress=zstd:1,noatime,subvol=@log /dev/$sda2 /mnt/var/log
mount -o compress=zstd:1,noatime,subvol=@snapshots /dev/$sda2 /mnt/.snapshots
mount /dev/$sda1 /mnt/boot/efi

# ------------------------------------------------------
# Instalar paquetes basicos
# ------------------------------------------------------
pacstrap -K /mnt base base-devel git linux linux-firmware nano vim openssh reflector rsync amd-ucode

# ------------------------------------------------------
# Generar el fstab
# ------------------------------------------------------
genfstab -U /mnt >> /mnt/etc/fstab
cat /mnt/etc/fstab

# ------------------------------------------------------
# Instalar configuracion  de scripts pre configuracion
# ------------------------------------------------------
mkdir /mnt/Arch_Base
cp 2-configuration.sh /mnt/Arch_Base/
cp 3-yay.sh /mnt/Arch_Base/
cp 4-zram.sh /mnt/Arch_Base/
cp 5-timeshift.sh /mnt/Arch_Base/
cp 6-preload.sh /mnt/Arch_Base/
cp snapshot.sh /mnt/Arch_Base/

# ------------------------------------------------------
# Chroot al sistema instalado
# ------------------------------------------------------
arch-chroot /mnt ./Arch_Base/2-configuration.sh

