{ pkgs, ... }:
{
  imports = [
    ./shell.nix
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      alacritty
      devour
      wezterm
    ];
  };
}
