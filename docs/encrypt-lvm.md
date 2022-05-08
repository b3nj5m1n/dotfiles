# Encrypt disk and partition using LVM

This replaces the part "Parition disk" in the general install guide.

## Format disk

First, list all disks:

```
lsblk
```

Find the one you want to format, for example /dev/sda. We're going to create a boot partition, which will not be encrypted, and a parition contatining lvm, which will be encrypted.

```
fdisk /dev/sdX
```

Create a new DOS partition table with `o`, then create the boot partition using `n`, accept the defaults except for the end of the partition, type in something like `+200M`. Now create the lvm partition with `n` and all the defaults. Change the partition type of the second partition to lvm with `t`, then 2 (or the number of the lvm partition), and `lvm`. Write the changes to disk using `w`. Veryify changes with `lsblk`.

## Setup encryption

Encrypt root partition:

```
cryptsetup luksFormat /dev/sdX2
```

Now open container to create lvm partitions:

```
cryptsetup open /dev/sdX2 NAME
```

where `NAME` is the name you want to give your lvm container, for example `root`.

### Create physical volume

```
pvcreate /dev/mapper/NAME
```

### Create volume group

```
vgcreate GROUPNAME /dev/mapper/NAME
```

where `GROUPNAME` is the name you want to give to the volume group, this will show up later in the partition name, for example a volume with the name `home` in a volume group with the name `v` will be called `v-home.`

#### Create volumes

Only the root one is really necessary, in this case there's going to be seperate partitions for /, /home, and swap.

```
lvcreate -L 100G GROUPNAME -n root # -L means absolute size
lvcreate -L 10G GROUPNAME -n swap
lvcreate -l 100%FREE GROUPNAME -n home # -l is relative size, in this case it will take up all the space that is left
```

#### Format volumes

```
mkfs.ext4 /dev/sdX1 # This is the boot partition, for UEFI I think it has to be fat32? also, you need to make the type uefi, in fdisk: t parition name uefi or something like that.
mkfs.ext4 /dev/GROUPNAME/root
mkfs.ext4 /dev/GROUPNAME/home
mkswap /dev/GROUPNAME/swap
```

#### Mount partitions

```
mount /dev/GROUPNAME/root /mnt
mount --mkdir /dev/GROUPNAME/home /mnt/home
mount --mkdir /dev/sdX1 /mnt/boot
swapon /dev/GROUPNAME/swap
```

## pacstrap base system

## Make mounts persistent

This is the same as in the normal installation:

```
genfstab -U /mnt >> /mnt/etc/fstab
```

## Proceed as normal with the installation

Using `arch-chroot`, proceed as normal, the only part you have to do differently is that you have to modify `mkinitcpio.conf` and the grub config.

### mkinitcpio

Edit `/etc/mkinitcpio.conf`.

In the hooks:

- After `keyboard`, add `keymap` (This has nothing to do with lvm, but I'm too lazy to add this section to the main guide atm)
- Before `filesystem`, add `encrypt` and `lvm2` (In that order)

Update with `mkinitcpio -p linux`.

### GRUB

`grub-install /dev/sdX` or, for UEFI: `grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB`

Edit `/etc/default/grub`.

Under `GRUB_CMDLINE_LINUX`, add `cryptdevice=UUID=YOURUUID:NAME root=/dev/GROUPNAME/root`, where `YOURUUID` is the UUID of /dev/sdX2, you can find this with `blkid`.

Update with `grub-mkconfig -o /boot/grub/grub.cfg`.
