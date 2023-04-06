{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./fonts.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      anki-bin
      dunst
      feh
      mangohud
      firefox
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
      (callPackage ../../pkgs/logseq-wrapped {})
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
    hardware.opengl.mesaPackage = pkgs.mesa_22; # Workaround TODO remove when fixed

    services.xserver.layout = "de";
    services.xserver.xkbOptions = "caps:escape";
  };
}
