{ pkgs, ... }:
{
  imports = [
    ./wayland.nix
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      swaylock-effects
      autotiling-rs
    ];
    programs.sway.enable = true;
    services.xserver.displayManager.defaultSession = "sway";
  };
}
