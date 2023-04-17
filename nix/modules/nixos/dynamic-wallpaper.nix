{pkgs, config, lib, ...}: with lib; let 
  cfg = config.services.dynamic-wallpaper;
in{
  imports = [
  ];

  options.services.dynamic-wallpaper = {
    enable = mkEnableOption "dynamic wallpaper service";
    theme = mkOption {
      type = types.str;
      default = "tokyo";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      swww
      pkgs.dynamic-wallpapers
    ];
    # systemd.user.timers."dynamic-wallpaper" = {
    #   wantedBy = ["timers.target"];
    #   timerConfig = {
    #     OnBootSec = "1h";
    #     OnUnitActiveSec = "1h";
    #     Unit = "dynamic-wallpaper.service";
    #   };
    # };
    systemd.services."dynamic-wallpaper" = mkIf cfg.enable {
      script = ''
        set -eu
        hour="$(date +%H)"
        ${pkgs.swww}/bin/swww img "${pkgs.dynamic-wallpapers}/images/${cfg.theme}/$hour.jpg"
      '';
      environment = {
        WAYLAND_DISPLAY = "wayland-1";
        XDG_RUNTIME_DIR = "/run/user/1000";
      };
      serviceConfig = {
        Type = "oneshot";
        User = "b3nj4m1n";
      };
      startAt = "minutely";
    };
  };
}
