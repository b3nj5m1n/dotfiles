{ pkgs, ... }:
{
  imports = [
    ./wayland.nix
  ];

  options = { };

  config = {
    programs.sway.enable = true;
    services.xserver.displayManager.defaultSession = "sway";
  };
}
