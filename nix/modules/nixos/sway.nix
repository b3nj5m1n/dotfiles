{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.ricefields.sway;
in {
  imports = [
    ./wayland.nix
    ./dynamic-wallpaper.nix
    ./swaylock-plugin.nix
  ];

  options = {
    ricefields.sway.useSwayFX = mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      swaylock-effects
      autotiling-rs
      sway-contrib.grimshot
    ];
    services.dynamic-wallpaper = {
      enable = true;
      theme = "tokyo";
      transitionDuration = 10;
    };
    services.swaylock-plugin = {
      enable = true;
    };
    programs.sway = {
      enable = true;
      package =
        if cfg.useSwayFX
        then pkgs.swayfx
        else pkgs.sway;
    };
    services.displayManager.defaultSession = "sway";
  };
}
