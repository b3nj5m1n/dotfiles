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
      dunst
      feh
      mangohud
      stable.firefox-bin
      (tor-browser-bundle-bin.override {
        useHardenedMalloc = false;
      })
      thunderbird
      libnotify
      neovide
      peek
      # pop-launcher
      syncthing
      ydotool
      xfce.thunar
      gnome.nautilus
      gnome.file-roller
      element-desktop
      mpv
      vlc
      zathura
      zotero
      gsmartcontrol
      swww
      stable.tts
      (callPackage ../../pkgs/logseq-wrapped {})
      libdrm
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

    services.xserver.displayManager.gdm.enable = true;
    # hardware.opengl.mesaPackage = pkgs.mesa_22; # Workaround TODO remove when fixed

    services.xserver.layout = "de";
    services.xserver.xkbOptions = "caps:escape";
  };
}
