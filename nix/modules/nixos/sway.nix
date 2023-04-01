{pkgs, ...}: {
  imports = [
    ./wayland.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      swaylock-effects
      autotiling-rs
      sway-contrib.grimshot
    ];
    programs.sway.enable = true;
    services.xserver.displayManager.defaultSession = "sway";
  };
}
