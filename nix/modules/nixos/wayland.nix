{ pkgs, ... }:
{
  imports = [
    ./desktop.nix
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      clipman
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
  };
}
