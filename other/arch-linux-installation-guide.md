# List available keyboard mappings
ls /usr/share/kbd/keymaps/**/*.mp.gz
# Temporary set keyboard layout for installation process
loadkeys de-latin1

# Connect to wifi
wifi-menu
# Verify connection
ping archlinux.org

# Update system clock
timedatectl set-ntp true
# Check status
timedatectl status

# List all disks
fdisk -l
# Set up new primary parition
fdisk /dev/sdX
# Format as ext4
mkfs.ext4 /dev/sdX1
# Optional: Create swap parition and enable it
mkswap /dev/sdX2
swapon /dev/sdX2
# Mount the filesystem
mount /dev/sdX1 /mnt

# Optional: Select mirrors
vim /etc/pacman.d/mirrorlist

# Pacstrap

pacstrap /mnt base linux linux-firmware vim sudo dhcp dhcpcd

genfstab -U /mnt >> /mnt/etc/fstab

# Chroot to systen
arch-chroot /mnt

# Set Time Zone
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
hwclock --systohc

# Localization
locale-gen
## Uncomment necessary locales
vim /etc/locale.gen
## Set LANG=en_US.UTF-8 variable
vim /etc/locale.conf
## Permanently set keyboard layout iwht KEYMAP=de-latin1
vim /etc/vsconsole.conf

# Set hostname (Put in hostname)
vim /etc/hostname
# Add 127.0.0.1     localhost
vim /etc/hosts

# Enable root for all users
visudo

# Add user
useradd -m username
## Set password
passwd username
## Add to wheel/sudo group
usermod -a -G wheel username
## Make sure .config (Or other) ownerships isn't screwed up
chown -R username /home/username

# AUR
polybar
nerd-fonts-ubuntu-mono
neovim-plug

# Enable dhcpcd client (internet)
systemctl enable dhcpcd
# Install wifi support
pacman -S dialog wpa_supplicant

# Install grub
pacman -S grub
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Update all packages
sudo pacman -Syu

# Install stuff
pacman -S binutils base-devel
# Install from my meta package
makepkg -sf


# Install desktop env
sudo pacman -S xorg
## Kde

sudo pacman -S plasma-meta kde-applications
sudo systemctl enable NetworkManager

## GNOME
sudo pacman -S gnome gnome-extra gdm

## XFCE
sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter

# Enable login manager
sudo systemctl enable sddm
sudo systemctl enable gdm
sudo systemctl enable lightdm

# Optional: Install xdg and create user dirs like pics or documents
sudo pacman -S xdg-user-dirs
xdg-user-dirs-update
