## Getting Plymouth to Work

### Hook

(Edit `/etc/mkinitcpio.conf`)

Add the plymouth hook after base & udev:
```
HOOKS=(base udev plymouth [...] )
```

### KMS

(Still `/etc/mkinitcpio.conf`)

Intel:
```
MODULES=(i915)
```
ATI:
```
MODULES=(radeon)
```
NVIDIA:
```
MODULES=(nouveau)
```

### Kernel Parameters

(Edit `etc/default/grub`)

Find the `GRUB_CMDLINE_LINUX_DEFAULT` option, try adding the following:

- quiet
- splash
- vga=current
- loglevel=0
- rd.udev.log_priority=0
- vt.global_cursor_default=0

You might have to enable KMS here as well using the following parameter:

- i915.modeset=1

## Make changes take effect

`sudo mkinitcpio -p linux --generate /boot/initramfs-linux.img`

`sudo grub-mkconfig --output=/boot/grub/grub.cfg` (running without `--output` is only a dry-run, took me way too long to realise that)

Then reboot. Good luck, you're gonna need it.

## Smooth transition to display manager

Disable the service for display manager, for example `sudo systemctl disable lighdm`, then enable the plymouth service for that, for example `sudo systemctl enable lightdm-plymouth`
