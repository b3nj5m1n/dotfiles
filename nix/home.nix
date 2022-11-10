{ config, pkgs, hyprland, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "b3nj4m1n";
  home.homeDirectory = "/home/b3nj4m1n";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  wayland.windowManager.sway = {
    enable = false;
    # config = rec {
    #   modifier = "Mod4";
    #   terminal = "wezterm";
    # };
  };
}
