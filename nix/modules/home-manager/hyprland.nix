{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  options = {};

  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      systemdIntegration = true;
      xwayland.enable = true;
      extraConfig = ''
        # monitor=,1920x1080@144,auto,auto

        exec-once = systemctl --user start graphical-session.target
        exec-once = ~/.config/eww/start-eww
        exec-once = wl-paste -t text --watch clipman store
        exec-once = firefox
        exec-once = syncthing -no-browser
        exec-once = systemctl --user start dynamic-wallpaper@skip.service

        env = XCURSOR_SIZE,24

        input {
            kb_layout = de
            kb_options = "caps:escape"
            follow_mouse = 1
        }
        device:razer-razer-blackwidow-elite-keyboard {
            kb_layout = de
            kb_options = "caps:escape"
        }

        general {
            gaps_in = 10
            gaps_out = 10
            border_size = 3
            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)

            layout = dwindle
        }

        decoration {
            rounding = 5
            blur = true
            blur_size = 3
            blur_passes = 3
            blur_new_optimizations = true

            drop_shadow = true
            shadow_offset = 5 5
            shadow_range = 5
            shadow_render_power = 3
            col.shadow = rgba(00000099)
        }

        animations {
            enabled = true

            bezier = myBezier, 0.05, 0.9, 0.1, 1.05

            animation = windows, 1, 7, myBezier
            animation = windowsOut, 1, 7, default, popin 80%
            animation = border, 1, 10, default
            animation = borderangle, 1, 8, default
            animation = fade, 1, 7, default
            animation = workspaces, 1, 6, default
        }

        dwindle {
            pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true # you probably want this
        }

        master {
            # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
            new_is_master = true
        }

        windowrule = noblur,^(firefox)$
        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        windowrulev2 = workspace 8,class:^(discord)$
        windowrulev2 = opacity 0.9 0.9,class:^(org\.wezfurlong\.wezterm)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

        $mainMod = SUPER

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod, Return, exec, wezterm
        bind = $mainMod SHIFT, C, killactive,
        bind = $mainMod SHIFT, Q, exit,
        # bind = $mainMod, E, exec, dolphin
        # bind = $mainMod, V, togglefloating,
        bind = $mainMod, D, exec, wofi --show drun
        # bind = $mainMod, P, pseudo, # dwindle
        # bind = $mainMod, J, togglesplit, # dwindle

        # Move focus with mainMod + arrow keys
        bind = $mainMod, h, movefocus, l
        bind = $mainMod, l, movefocus, r
        bind = $mainMod, k, movefocus, u
        bind = $mainMod, j, movefocus, d

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        bind = $mainMod, 9, workspace, 9
        bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow
      '';
    };
  };
}
