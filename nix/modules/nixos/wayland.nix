{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./desktop.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      cliphist
      eww-wayland
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
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # extraPortals = with pkgs; [
      #   xdg-desktop-portal-wlr
      #   xdg-desktop-portal-gtk
      # ];
    };
  };
}
