{ pkgs, ... }:
{
  imports = [
    ./audio.nix
    ./fonts.nix
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      dunst
      feh
      firefox
      thunderbird
      libnotify
      neovide
      peek
      # pop-launcher
      syncthing
      ydotool
      logseq-wrapped
      xfce.thunar
      gnome.nautilus
      gnome.file-roller
      element-desktop
      zathura
      zotero
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

    services.xserver.layout = "de";
    services.xserver.xkbOptions = "caps:escape";
  };
}
