## Getting Hibernation to Work

### Kernel Parameters

(Edit `etc/default/grub`)

Find the `GRUB_CMDLINE_LINUX_DEFAULT` option, add the following:

- `resume=/dev/sdX1` (Parition containing swapfile, can also be uuid)
- `resume_offset=OFFSET` (Offset, can be obtained with the following command: `filefrag -v /swapfile | awk '$1=="0:" {print substr($4, 1, length($4)-2)}'`, alternatively execute `filefrag -v /swapfile` and look for the first value in the physical_offset column, row 0)

### Hook

(Edit `/etc/mkinitcpio.conf`)

Add the resume hook after base & udev (before plymouth):
```
HOOKS=(base udev resume [...] )
```

## Make changes take effect

`sudo mkinitcpio -p linux --generate /boot/initramfs-linux.img`

`sudo grub-mkconfig --output=/boot/grub/grub.cfg`
