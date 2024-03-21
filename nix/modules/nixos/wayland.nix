{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./desktop.nix
    ./ulauncher.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      cliphist
      eww
      kanshi
      tofi
      wayland
      wev
      wl-clipboard
      wlr-randr
      wlprop
      wofi
    ];
    hardware.brillo.enable = true;
    services.dbus.enable = true;
    security.pam.services.swaylock = {};
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # lxqt.enable = true;
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
      # extraPortals = with pkgs; [
      #   xdg-desktop-portal-wlr
      #   xdg-desktop-portal-gtk
      # ];
    };
  };
}
