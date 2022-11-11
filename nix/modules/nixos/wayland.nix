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
      light
      tofi
      wayland
      wev
      wl-clipboard
      wlr-randr
      wofi
    ];
  };
}
