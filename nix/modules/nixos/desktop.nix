{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./fonts.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      anki-bin
      pr454485.calibre
      swaynotificationcenter
      feh
      mangohud
      (tor-browser.override {
        # useHardenedMalloc = false;
      })
      thunderbird
      libnotify
      neovide
      peek
      # pop-launcher
      syncthing
      ydotool
      thunar
      nautilus
      file-roller
      stable.element-desktop
      mpv
      vlc
      zathura
      gsmartcontrol
      awww
      rnote
      xournalpp
      inkscape-with-extensions
      stable.kgeotag
      (callPackage ../../pkgs/zotero-wrapped {})
      # (callPackage ../../pkgs/logseq-wrapped {})
      # (callPackage ../../pkgs/firefox-trapped {})
      firefox
      pr331310.qutebrowser
    ];

    services = {
      syncthing = {
        enable = true;
        user = "b3nj4m1n";
        dataDir = "/home/b3nj4m1n/.local/share";
        configDir = "/home/b3nj4m1n/.config/syncthing";
      };
    };

    services.xserver.enable = true;

    # TODO Use the same DM config on both systems
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = "dur_file";
        dur_file_path = "/usr/local/share/wallpaper/blackhole.dur";
        asterisk = "0x2022";
        vi_mode = true;
        vi_default_mode = "insert";
      };
    };
    /*
    services.xserver.displayManager.lightdm = {
    greeters = {
    slick.enable = true;
    };
    };
    */
    # hardware.opengl.mesaPackage = pkgs.mesa_22; # Workaround TODO remove when fixed

    services.xserver.xkb = {
      options = "caps:escape";
      layout = "de";
    };

    xdg.mime = {
      enable = true;
      defaultApplications = {
        "application/pdf" = "org.pwmt.zathura.desktop";
      };
    };
  };
}
