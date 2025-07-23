{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  options = {};

  config = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;
      settings = {
        mainBar = {
          "layer" = "top";
          "position" = "top";
          "spacing" = 1;
          "height" = 0;
          "modules-left" = [
            "custom/logo"
            "sway/workspaces"
          ];
          "modules-center" = [
            "sway/window"
          ];
          "modules-right" = [
            "tray"
            "memory"
            "network"
            "wireplumber"
            "battery"
            "clock"
          ];
          "sway/window" = {
            "format" = "{title}";
            "max-length" = 50;
            "rewrite" = {
              "(.*) - Mozilla Firefox" = "🌎 $1";
              "nvim (.*)" = "  $1";
              "(.*) - zsh" = "🦀 $1";
              "zsh" = "🦀🦀🦀";
            };
          };
          "wlr/taskbar" = {
            "format" = "{icon}";
            "on-click" = "activate";
            "on-click-right" = "fullscreen";
            "icon-theme" = "WhiteSur";
            "icon-size" = 25;
            "tooltip-format" = "{title}";
          };
          "memory" = {
            "interval" = 5;
            "format" = "󰍛 {}%";
            "max-length" = 10;
          };
          "tray" = {
            "spacing" = 15;
          };
          "clock" = {
            "format" = "<span weight=\"bold\">{:%R</span>, %d %B %Y [%A]}";
            "format-alt" = "{:%H:%M}";
            "tooltip-format" = "<tt><small>{calendar}</small></tt>";
            "calendar" = {
              "mode" = "year";
              "mode-mon-col" = 3;
              "weeks-pos" = "right";
              "on-scroll" = 1;
              "format" = {
                "months" = "<span color='#ffead3'><b>{}</b></span>";
                "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                "weeks" = "<span color='#99ffdd'><b>W{}</b></span>";
                "weekdays" = "<span color='#ffcc66'><b>{}</b></span>";
                "today" = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
            "actions" = {
              "on-click-right" = "mode";
              # "on-scroll-up" = "tz_up";
              # "on-scroll-down" = "tz_down";
              # "on-scroll-up" = "shift_up";
              # "on-scroll-down" = "shift_down";
            };
          };
          "network" = {
            "format-wifi" = "{icon}";
            "format-icons" = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            "format-ethernet" = "󰀂";
            "format-alt" = "󱛇";
            "format-disconnected" = "󰖪";
            "tooltip-format-wifi" = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            "tooltip-format-ethernet" = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
            "tooltip-format-disconnected" = "Disconnected";
            "interval" = 5;
            "nospacing" = 1;
          };
          "wireplumber" = {
            "format" = "{icon} {volume}%";
            "format-bluetooth" = "󰂰";
            "nospacing" = 1;
            "tooltip-format" = "Volume  = {volume}%";
            "format-muted" = "󰝟";
            "format-icons" = {
              "headphone" = "";
              "default" = ["󰖀" "󰕾" ""];
            };
            "scroll-step" = 1;
          };
          "custom/logo" = {
            "format" = "λ";
            "tooltip" = false;
          };
          "battery" = {
            "format" = "{capacity}% {icon}";
            "format-icons" = {
              "charging" = [
                "󰢜"
                "󰂆"
                "󰂇"
                "󰂈"
                "󰢝"
                "󰂉"
                "󰢞"
                "󰂊"
                "󰂋"
                "󰂅"
              ];
              "default" = [
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
            "format-full" = "Charged ";
            "interval" = 5;
            "states" = {
              "warning" = 20;
              "critical" = 10;
            };
            "tooltip" = false;
          };
        };
      };
      style = ''
        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: JetBrainsMono Nerd Font;
          font-size: 13px;
        }

        window#waybar {
          background-color: #181825;
          transition-property: background-color;
          transition-duration: 0.5s;
        }

        window#waybar.hidden {
          opacity: 0.5;
        }

        #workspaces {
                      background-color: transparent;
                    }

        #workspaces button {
                      all: initial;
                      /* Remove GTK theme values (waybar #1351) */
                      min-width: 0;
                      /* Fix weird spacing in materia (waybar #450) */
                      box-shadow: inset 0 -3px transparent;
                      /* Use box-shadow instead of border so the text isn't offset */
                      padding: 6px 18px;
                      margin: 6px 3px;
                      border-radius: 4px;
                      background-color: #1e1e2e;
                      color: #cdd6f4;
                    }

        #workspaces button.active {
                      color: #1e1e2e;
                      background-color: #cdd6f4;
                    }

        #workspaces button:hover {
                      box-shadow: inherit;
                      text-shadow: inherit;
                      color: #1e1e2e;
                      background-color: #cdd6f4;
                    }

        #workspaces button.urgent {
                      background-color: #f38ba8;
                    }

        #memory,
        #custom-power,
        #battery,
        #backlight,
        #wireplumber,
        #network,
        #clock,
        #tray {
                      border-radius: 4px;
                      margin: 6px 3px;
                      padding: 6px 12px;
                      background-color: #1e1e2e;
                      color: #181825;
                    }

        #custom-power {
                      margin-right: 6px;
                    }

        #custom-logo {
                      padding-right: 7px;
                      padding-left: 7px;
                      margin-left: 5px;
                      font-size: 20px;
                      border-radius: 8px 0px 0px 8px;
                      color: #ffffff;
                    }

        #memory {
                      background-color: #fab387;
                    }

        #battery {
                      background-color: #f38ba8;
                    }

        #battery.warning,
        #battery.critical,
        #battery.urgent {
                      background-color: #ff0000;
                      color: #FFFF00;
                    }

        #battery.charging {
                      background-color: #a6e3a1;
                      color: #181825;
                    }

        #backlight {
                      background-color: #fab387;
                    }

        #wireplumber {
                      background-color: #f9e2af;
                    }

        #network {
                      background-color: #94e2d5;
                      padding-right: 17px;
                    }

        #clock {
                      font-family: JetBrainsMono Nerd Font;
                      background-color: #cba6f7;
                    }

        #custom-power {
                      background-color: #f2cdcd;
                    }


                    tooltip {
                      border-radius: 8px;
                      padding: 15px;
                      background-color: #131822;
                    }

                    tooltip label {
                      padding: 5px;
                      background-color: #131822;
                    }

        #window {
                        color: #ffffff;
                    }
      '';
    };
  };
}
