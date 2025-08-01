{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.dynamic-wallpaper;
in {
  imports = [
  ];

  options.services.dynamic-wallpaper = {
    enable = mkEnableOption "dynamic wallpaper service";
    theme = mkOption {
      type = types.str;
      default = "tokyo";
    };
    noResize = mkEnableOption "Do not resize the image. If the image is smaller than the screen's size, it will be padded with the value of `fill_color`.";
    fillColor = mkOption {
      description = "Which color to fill the padding with when not resizing";
      type = types.str;
      default = "000000";
    };
    filter = mkOption {
      description = "Filter to use when scaling images. Available options are Nearest, Bilinear, CatmullRom, Mitchell, Lanczos3.";
      type = types.str;
      default = "Lanczos3";
    };
    sync = mkEnableOption "Sync the animations' frames between monitors";
    transitionType = mkOption {
      description = "Type of transition. Available options are simple, left, right, top, bottom, wipe, wave, grow, center, any, outer, random.";
      type = types.str;
      default = "wipe";
    };
    transitionStep = mkOption {
      description = "How fast the transition approaches the new image. 255 switches immediately.";
      type = types.int;
      default = 90;
    };
    transitionDuration = mkOption {
      description = "How many seconds the transition takes to complete.";
      type = types.int;
      default = 3;
    };
    transitionFps = mkOption {
      description = "Frame rate for the transition effect.";
      type = types.int;
      default = 144;
    };
    transitionAngle = mkOption {
      description = "Angle in degrees used in the wipe and wave transition type. 0 is right to left, 90 top to bottom, 270 bottom to top.";
      type = types.int;
      default = 30;
    };
    transitionPosition = mkOption {
      description = "Controls the center of the cricle in grow and outer transition type.
      Position values can be given in both percentage values and pixel values:
      float values are interpreted as percentages and integer values as pixel
      values eg: 0.5,0.5 means 50% of the screen width and 50% of the screen height
      200,400 means 200 pixels from the left and 400 pixels from the bottom

      the value can also be an alias which will set the position accordingly):
      'center' | 'top' | 'left' | 'right' | 'bottom' | 'top-left' | 'top-right' |
      'bottom-left' | 'bottom-right'";
      type = types.str;
      default = "center";
    };
    transitionBezier = mkOption {
      description = "Bezier curve used for transition.";
      type = types.str;
      default = ".54,0,.34,.99";
    };
    transitionWaveProperties = mkOption {
      description = "Controls the width and height of each wave in the wave transition type.";
      type = types.str;
      default = "20,20";
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      swww
      pkgs.dynamic-wallpapers
    ];
    # Service for starting the swww daemon
    systemd.user.services."swww-daemon" = mkIf cfg.enable {
      unitConfig = {
        "Description" = "Solution to Wayland Wallpaper Woes";
        "Requires" = "graphical-session.target";
        "PartOf" = "graphical-session.target";
        "After" = "graphical-session.target";
      };
      serviceConfig = {
        Type = "notify";
        ExecStart = "${pkgs.swww}/bin/swww-daemon";
        NotifyAccess = "all";
      };
      wantedBy = [
        "graphical-session.target"
      ];
      path = [pkgs.swww];
      environment = {
        WAYLAND_DISPLAY = "wayland-1";
        XDG_RUNTIME_DIR = "/run/user/1000";
      };
    };
    # Service which sets the current wallpaper to the wallpaper corresponding to the current hour
    #   systemctl --user start dynamic-wallpaper@default.service # Use settings specified by this module
    #   systemctl --user start dynamic-wallpaper@skip.service # Skip transition and immediately set the image as background
    systemd.user.services."dynamic-wallpaper@" = mkIf cfg.enable {
      unitConfig = {
        "Description" = "Dynamically change wallpaper based on time of day";
        "Requires" = "swww-daemon.service";
        "PartOf" = "swww-daemon.service";
        "After" = "swww-daemon.service";
      };
      script = let
        flags = builtins.concatStringsSep " " (
          builtins.filter (x: x != "") [
            "${
              if cfg.noResize
              then "--no-resize"
              else ""
            }"
            "${
              if cfg.noResize
              then "--fill-color ${cfg.fillColor}"
              else ""
            }"
            "--filter ${cfg.filter}"
            "${
              if cfg.sync
              then "--sync"
              else ""
            }"
            "--transition-type ${cfg.transitionType}"
            "--transition-step ${toString cfg.transitionStep}"
            "--transition-duration ${toString cfg.transitionDuration}"
            "--transition-fps ${toString cfg.transitionFps}"
            "--transition-angle ${toString cfg.transitionAngle}"
            "--transition-pos ${cfg.transitionPosition}"
            "--transition-bezier ${cfg.transitionBezier}"
            "${
              if cfg.transitionType == "wave"
              then "--transition-wave ${cfg.transitionWaveProperties}"
              else ""
            }"
          ]
        );
        command = "${pkgs.swww}/bin/swww img";
        image = "${pkgs.dynamic-wallpapers}/images/${cfg.theme}/$hour.jpg";
      in ''
        set -eu
        hour="$(date +%k | xargs)" # xargs removes leading whitespace
        if [ "$1" = "skip" ]; then
          ${command} --transition-duration 0 ${image}
        else
          ${command} ${flags} ${image}
        fi
      '';
      scriptArgs = "%i";
      environment = {
        WAYLAND_DISPLAY = "wayland-1";
        XDG_RUNTIME_DIR = "/run/user/1000";
      };
      serviceConfig = {
        Type = "oneshot";
      };
    };
    # Run the dynamic-wallpaper service every hour
    systemd.user.timers."dynamic-wallpaper" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "1h";
        OnUnitActiveSec = "1h";
        Unit = "dynamic-wallpaper@default.service";
      };
    };
  };
}
