{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ./dynamic-wallpaper.nix
    ./swaylock-plugin.nix
  ];

  options = {};

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
    programs.sway.enable = true;
    services.displayManager.defaultSession = "sway";
  };
}
