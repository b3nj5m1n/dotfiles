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
      libnotify
      neovide
      peek
      syncthing
      ydotool
      logseq
      zathura
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
