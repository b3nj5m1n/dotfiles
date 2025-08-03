{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  #––– TEMPLATED VARIABLES –––
  main_monitor = "TODO"; # TODO
  main_monitor_res = "TODO"; # TODO
  second_monitor = "TODO"; # TODO

  colors = {
    yellow = "TODO";
    orange = "TODO";
    background = "TODO";
    fg = "TODO";
    cyan = "TODO";
    red = "TODO";
  }; # TODO

  #––– SWAY VARIABLES –––
  left = "h";
  down = "j";
  up = "k";
  right = "l";

  menu = "tofi-run | xargs swaymsg exec --";
  # lock = ''swaylock --screenshots --clock --indicator --indicator-caps-lock --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --grace 2 --fade-in 0.2 --indicator-idle-visible --color 24273a --bs-hl-color ${builtins.removeHash colors.yellow} --caps-lock-bs-hl-color ${builtins.removeHash colors.orange} --caps-lock-key-hl-color ${builtins.removeHash colors.orange} --key-hl-color c6a0f6 --separator-color 00000000 --inside-color 00000000 --line-color 00000000 --ring-color ${builtins.removeHash colors.background} --text-color ${builtins.removeHash colors.fg} --inside-clear-color 00000000 --line-clear-color 00000000 --ring-clear-color ${builtins.removeHash colors.cyan} --text-clear-color ${builtins.removeHash colors.cyan} --inside-caps-lock-color 00000000 --line-caps-lock-color 00000000 --ring-caps-lock-color ${builtins.removeHash colors.yellow} --text-caps-lock-color ${builtins.removeHash colors.yellow} --inside-ver-color 00000000 --line-ver-color 00000000 --ring-ver-color ${builtins.removeHash colors.orange} --text-ver-color ${builtins.removeHash colors.orange} --inside-wrong-color 00000000 --line-wrong-color 00000000 --ring-wrong-color ${builtins.removeHash colors.red} --text-wrong-color ${builtins.removeHash colors.red}'';
  lock = ''swaylock'';

  disable_touchpad = false; # TODO
  touchpad_id = "TODO"; # TODO
in
{
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway;
    xwayland = true;

    config = {

      # SUPER key as mod. I've used ALT for like 2 years now because I initially
      # thought it was a good idea, but it really, really isn't. Many other programs,
      # for example firefox, use the alt key for stuff of varying importance. (In
      # firefox, you can use it to quickly get to another tab, for example ALT+2 will
      # get you to the second tab)
      # Many programs, pretty much all the electron apps for example, open their menu
      # at the top when you press alt, or, more specifically, when you release alt.
      # This means that when you press ALT+2 to switch to your second workspace with
      # firefox on it, and once you're there you let go of the alt key, the menu will
      # open up. This is an issue, for example it unfocuses text fields. Say you're
      # taking your daily notes in logseq, you switch to your firefox workspace to
      # copy some text, go back to your logseq workspace, logseq opens up its menu at
      # the top and you now have first press alt to get out of the menu again, then
      # click to get back to entering text.
      # Choosing ALT was a bad decision, but thankfully it seems like switching back
      # isn't going to require as much work as I had thought.
      modifier = "Mod4";

      terminal = "ghostty";

      menu = "tofi-run | xargs swaymsg exec --";

      input = lib.mkMerge [
        {
          "*" = {
            xkb_layout = "de";
            xkb_options = "caps:escape";
          };
        }
        (
          if disable_touchpad then
            {
              "${touchpad_id}" = {
                events = "disabled";
              };
            }
          else
            { }
        )
      ];

      # Hide cursor after 2 seconds of inactivity
      seat = {
        "*" = {
          hide_cursor = "2000";
          xcursor_theme = "\"Bibata-Original-Ice\" 24";
        };
      };

      gaps = {
        inner = 10;
      };
      window = {
        border = 3;
      };
      colors = {
        background = "#FFFFFF";
        focused = {
          border = "#8bd5ca";
          background = "#8bd5ca";
          text = "#fcfcfe";
          indicator = "#8bd5ca";
          childBorder = "#8bd5ca";
        };
        focusedInactive = {
          border = "#24273a";
          background = "#24273a";
          text = "#fcfcfe";
          indicator = "#24273a";
          childBorder = "#24273a";
        };
        unfocused = {
          border = "#24273a";
          background = "#24273a";
          text = "#fcfcfe";
          indicator = "#24273a";
          childBorder = "#24273a";
        };
        urgent = {
          border = "#ed8796";
          background = "#ed8796";
          text = "#fcfcfe";
          indicator = "#ed8796";
          childBorder = "#ed8796";
        };
        placeholder = {
          border = "#24273a";
          background = "#24273a";
          text = "#fcfcfe";
          indicator = "#24273a";
          childBorder = "#0C0C0C";
        };
      };

      assigns = {
        "1" = [
          { app_id = "org.qutebrowser.qutebrowser"; }
        ];
        "2" = [
          { app_id = "firefox"; }
        ];
        "3" = [
          { class = "Logseq"; }
        ];
        "8" = [
          { app_id = "discord"; }
        ];
        "9" = [
          { app_id = "thunderbird"; }
        ];
      };

      keybindings = mkOptionDefault {
        ## Essential Keybindings
        # Terminal stuff
        "${config.wayland.windowManager.sway.config.modifier}+Shift+Return" =
          "exec \$${config.wayland.windowManager.sway.config.terminal} -e zsh";
        "${config.wayland.windowManager.sway.config.modifier}+ctrl+t" =
          "exec \$${config.wayland.windowManager.sway.config.terminal} -e tmux attach";
        # Latex OCR
        "Shift+Mod1+Mod4+l" = "exec /run/current-system/sw/bin/pix2tex";
        # Screenshot
        "Shift+Mod1+Mod4+s" = "exec \"/run/current-system/sw/bin/grimshot copy area\"";
        # Start launcher
        "${config.wayland.windowManager.sway.config.modifier}+d" = "exec ulauncher-toggle";
        # Open clipboard manager
        "Mod1+h" = "exec cliphist list | wofi -dmenu | cliphist decode | wl-copy";
        # Open calculator
        "Mod1+g" = "exec wofi-calc";
        # Open emoji picker
        "Mod1+u" = "exec bemoji";
        # Lock
        "${config.wayland.windowManager.sway.config.modifier}+q" = "exec ${lock}";

        # Open pdf of course script
        "${config.wayland.windowManager.sway.config.modifier}+Shift+s" =
          "exec /home/b3nj4m1n/uni/open-script.sh";

        ## Volume Control
        # Increase volume
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +3%";
        "F3" = "exec pactl set-sink-volume @DEFAULT_SINK@ +3%";
        "Mod1+Shift+plus" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";

        # Decrease volume
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -3%";
        "F2" = "exec pactl set-sink-volume @DEFAULT_SINK@ -3%";
        "Mod1+Shift+minus" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";

        # Mute
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "F1" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "Mod1+Shift+m" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

        ## Brightness Control
        # Increase brightness
        "XF86MonBrightnessUp" = "exec brillo -A 5% -u 200000";
        "F6" = "exec brillo -A 5% -u 200000";
        "Mod4+Shift+plus" = "exec brillo -A 5% -u 200000";

        # Increase brightness
        "XF86MonBrightnessDown" = "exec brillo -U 5% -u 200000";
        "F5" = "exec brillo -U 5% -u 200000";
        "Mod4+Shift+minus" = "exec brillo -U 5% -u 200000";

        ## Player Control
        # Pause playback
        "XF86AudioPlay" = "exec mpc toggle";
        "${config.wayland.windowManager.sway.config.modifier}+p" = "exec mpc toggle";

        # Next song
        "XF86AudioNext" = "exec mpc next";
        "${config.wayland.windowManager.sway.config.modifier}+n" = "exec mpc next";

        # Previous song
        "XF86AudioPrev" = "exec mpc prev";
        "${config.wayland.windowManager.sway.config.modifier}+m" = "exec mpc prev";

        ## Sway Stuff
        # Kill focused window
        "${config.wayland.windowManager.sway.config.modifier}+Shift+c" = "kill";
        # Reload config
        "${config.wayland.windowManager.sway.config.modifier}+Shift+r" = "reload";
        # Exit sway (logs you out of your Wayland session)
        "${config.wayland.windowManager.sway.config.modifier}+Shift+q" =
          "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";
        # Open notification center
        "Mod1+c" = "exec swaync-client -t";
        # Enable resize mode
        "${config.wayland.windowManager.sway.config.modifier}+r" = "mode resize";

      };

      modes = {
        resize = {
          Escape = "mode default";
          Return = "mode default";
          "h" = "resize shrink width 10px";
          "j" = "resize grow height 10px";
          "k" = "resize shrink height 10px";
          "l" = "resize grow width 10px";
        };
      };

      bars = [ ];
    };

    extraConfig = ''
      # Startup
      exec systemctl --user start graphical-session.target
      exec systemctl --user start dynamic-wallpaper@skip.service
      exec systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP
      exec dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      exec systemctl --user start ulauncher
      exec kdeconnect-cli -l
      exec swaync
      exec wl-paste --type text --watch cliphist store
      exec wl-paste --type image --watch cliphist store
      exec syncthing -no-browser
      exec nm-applet
      exec firefox
      exec autotiling-rs

      # Lock
      # exec \$${lock}
    '';
  };
}
