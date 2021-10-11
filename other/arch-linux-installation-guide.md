# Base System Install

## Set keyboard layout

### List available keyboard mappings

```
ls /usr/share/kbd/keymaps/**/*.map.gz
```

### Temporary set keyboard layout for installation process

```
loadkeys de-latin1
```


## Connect to the internet

### Wifi

```
iwctl
station wlan0 connect ssid
exit
```

### Ethernet

dhcpcd is enabled by default

### Verify

```
ping archlinux.org
```


## Set time

### Update system clock

```
timedatectl set-ntp true
```

### Check status

```
timedatectl status
```


## Partition disk

### List all disks

```
fdisk -l
```

### Set up new primary partition

```
fdisk /dev/sdX
```

Create a new partition table (DOS), then new partition (type primary, partition number 1, from first available sector to last available sector), then write.

### Format as ext4

```
mkfs.ext4 /dev/sdX1
```

### Mount the filesystem

```
mount /dev/sdX1 /mnt
```


## Pacstrap

### Optional: Select mirrors

#### Manual

```
vim /etc/pacman.d/mirrorlist
```

#### Automatic

```
reflector > /etc/pacman.d/mirrorlist
```

### Install system

The bare minimum packages required are `base linux linux-firmware`.

```
pacstrap /mnt base linux linux-firmware neovim sudo dhcpcd iwd grub inutils fakeroot base-devel
```

### Put mount in fstab

```
genfstab -U /mnt >> /mnt/etc/fstab
```


# Set up

## Chroot to system

```
arch-chroot /mnt
```

## Set time zone

```
ln -sf /usr/share/zoneinfo/REGION/CITY /etc/localtime
hwclock --systohc
```

## Set locale

### Uncomment necessary locales

```
nvim /etc/locale.gen
```

### Generate locales

```
locale-gen
```

### Set language variable & console key layout

```
echo "LANG=en_GB.UTF-8" > /etc/locale.conf
echo "KEYMAP=de-latin1" > /etc/vconsole.conf
```

## Network config

### Set hostname

```
hostnamectl set-hostname HOSTNAME
```

## Users

### Enable root for wheel users

```
visudo
```

(If vim is not installed, first do `export EDITOR=nvim`)

Uncomment the line under `Uncomment to allow members of group wheel to execute any command`

### Add user

#### Add user with wheel group and create a home dir for them

```
useradd --gid users --groups wheel -m USERNAME
```

(To add a group after the user has been created)
```
usermod -a -G wheel USERNAME
```

#### Set password

```
passwd USERNAME
```

(Also do this for the root user)


## Install GRUB

(The grub package has to be installed)

### Install to disk

```
grub-install /dev/sdX
```

### Create grub config

```
grub-mkconfig -o /boot/grub/grub.cfg
```


## Enable internet on new system

### Enable services

```
systemctl enable dhcpcd
systemctl enable systemd-networkd
systemctl enable systemd-resolved
```

## Set up swap file

```
fallocate -l 6G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo "/swapfile none swap defaults 0 0" >> /etc/fstab
```

## Reboot

```
exit
reboot
```

## GUI

Install xorg, a login manager & a window manager.

```
pacman -S xorg bspwm lightdm lightdm-gtk-greeter
```

### Enable login manager service

(Make sure to first verify the login manager works by doing `systemctl start lightdm`)

```
systemctl enable lightdm
```

## Install programs and get dotfiles

### Clone dotfiles repo

```
git clone https://github.com/b3nj5m1n/dotfiles
```

### Install meta package

```
%% cd dotfiles/other/arch-meta/
%% makepkg -s
source PKGBUILD && yay -Syu --needed --asdeps "${makedepends[@]}" "${depends[@]}"
```

<!-- ### Move dotfiles
cd dotfiles/
./conf-files-updater.sh
### Get bigconf & move
git clone https://github.com/b3nj5m1n/bigconf
cd bigconf
./conf-files-updater.sh
## Install yay and AUR packages
cd dotfiles/
./package-installer.sh --yay
yay -S polybar
yay -S neovim-plug
yay -S powerline-fonts-git
yay -S bluej
yay -S keeweb
yay -S openrazer-meta-git
yay -S polychromatic
yay -S tty-clock
yay -S slop
yay -S betterlockscreen
yay -S libxft-bgra
yay -S ntfs-3g-fuse
yay -S python-ueberzug-git
## Fonts
yay -S ttf-twemoji
yay -S siji-git
yay -S nerd-fonts-ubuntu-mono
yay -S nerd-fonts-cascadia-code
yay -S nerd-fonts-roboto-mono

 -->
