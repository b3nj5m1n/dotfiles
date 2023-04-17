{pkgs, ...}: {
  imports = [
    ./wayland.nix
    ./dynamic-wallpaper.nix
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
    };
    programs.sway.enable = true;
    services.xserver.displayManager.defaultSession = "sway";
  };
}
