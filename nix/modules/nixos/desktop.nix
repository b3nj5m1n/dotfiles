{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./fonts.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      anki-bin
      calibre
      swaynotificationcenter
      feh
      mangohud
      (tor-browser-bundle-bin.override {
        # useHardenedMalloc = false;
      })
      thunderbird-128
      libnotify
      neovide
      peek
      # pop-launcher
      syncthing
      ydotool
      xfce.thunar
      nautilus
      file-roller
      stable.element-desktop
      mpv
      vlc
      zathura
      gsmartcontrol
      swww
      rnote
      xournalpp
      inkscape-with-extensions
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
