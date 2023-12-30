{
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
  ];

  config = {
    environment.systemPackages = with pkgs; [
    ];

    systemd.services = {
      battery-check = {
        description = "Check if battery needs to be swapped";
        path = with pkgs; [kbd];
        environment = {
          WAYLAND_DISPLAY = "wayland-1";
          XDG_RUNTIME_DIR = "/run/user/1000";
        };
        serviceConfig = {
          #User = "b3nj4m1n";
          ExecStart = "-${pkgs.bash}/bin/bash /home/b3nj4m1n/.local/share/bin/bsod.sh";
        };
        # timer = "your-script-timer";
      };
    };

    systemd.timers."battery-check" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "1m";
        OnUnitActiveSec = "1m";
        Unit = "battery-check.service";
      };
    };

    /*
       systemd.services = {
      "battery-check" = {
        script = ''
          battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
          if [ "$battery_level" -lt 60 ]; then
            /home/b3nj4m1n/.local/share/bin/bsod.sh
          else
            /home/b3nj4m1n/.local/share/bin/bsod.sh
          fi
        '';
      };
    };
    */
  };
}
