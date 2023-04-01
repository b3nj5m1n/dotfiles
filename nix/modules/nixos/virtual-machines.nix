{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      qemu_full
      virt-manager
      virt-viewer
      dnsmasq
      vde2
      bridge-utils
      netcat-openbsd
      libguestfs
    ];
    virtualisation.libvirtd.enable = true;
    programs.dconf.enable = true;
  };
}
