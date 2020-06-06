######################### Base System Install #########################

# Set keyboard layout
## List available keyboard mappings
ls /usr/share/kbd/keymaps/**/*.mp.gz
## Temporary set keyboard layout for installation process
loadkeys de-latin1

# Connect to the internet
## Wifi
wifi-menu
## Ethernet
dhcpcd is enabled by default
## Verify
ping reddit.com

# Set time
## Update system clock
timedatectl set-ntp true
## Check status
timedatectl status

# Partition disk
## List all disks
fdisk -l
## Set up new primary partition
fdisk /dev/sdX
## Format as ext4
mkfs.ext4 /dev/sdX1
## Mount the filesystem
mount /dev/sdX1 /mnt

# Pacstrap
## Optional: Select mirrors
vim /etc/pacman.d/mirrorlist
## Install base system
pacstrap /mnt base linux linux-firmware
## Install some important packages
pacstrap /mnt vim sudo dhcpcd
## Put mount in fstab
genfstab -U /mnt >> /mnt/etc/fstab

######################### Set up #########################

# Set up system
### Chroot to system
arch-chroot /mnt
## Set time zone
ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime
hwclock --systohc
## Set locale
locale-gen
### Uncomment necessary locales
vim /etc/locale.gen
### Set language variable
vim /etc/locale.conf
`LANG=en_GB.UTF-8`
## Network config
### Set hostname
hostnamectl set-hostname HOSTNAME
## Enable root for wheel users
visudo
## Add user
### Add user with wheel group and create a home dir for them
useradd --gid users --groups wheel -m USERNAME
#### Add user to wheel group if not done in the previous step
usermod -a -G wheel USERNAME
### Set password
passwd USERNAME

# Install GRUB
## Install package
pacman -S grub
## Install to disk
grub-install /dev/sdX
## Create grub config
grub-mkconfig -o /boot/grub/grub.cfg

# Enable internet on new system
## Install wifi support
pacman -S dialog wpa_supplicant
## Enable service for ethernet
systemctl enable dhcpcd

# GUI
## Install xorg
pacman -S xorg
## Install wm
pacman -S bspwm

# DM
## Install dm
pacman -S lightdm lightdm-gtk-greeter
## Start/Enable
systemctl start lightdm
systemctl enable lightdm

# Set up swap file
## Create swap file
fallocate -l 6G /swapfile
## Set permissions
chmod 600 /swapfile
## Format as swap
mkswap /swapfile
## Activate swap
swapon /swapfile
## Put in fstab
/swapfile none swap defaults 0 0

# Install programs and get dotfiles
## Install helper programs
pacman -S git binutils fakeroot base-devel
## Clone dotfiles repo
git clone https://github.com/b3nj5m1n/dotfiles
## Install meta package
cd dotfiles/other/arch-meta/
makepkg -s
## Move dotfiles
cd dotfiles/
./conf-files-updater.sh
## Get bigconf & move
git clone https://github.com/b3nj5m1n/bigconf
cd bigconf
./conf-files-updater.sh
# Install yay and AUR packages
cd dotfiles/
./package-installer.sh --yay
yay -S polybar
yay -S nerd-fonts-ubuntu-mono
yay -S neovim-plug
yay -S powerline-fonts-git
yay -S bluej
yay -S keeweb
yay -S openrazer-meta-git
yay -S polychromatic
yay -S tty-clock
yay -S slop
yay -S betterlockscreen


