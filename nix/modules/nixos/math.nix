{pkgs, ...}: {
  imports = [
    # ./neovim.nix
    ./zsh.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      libqalculate # qalc cli
      sage
      sagetex
    ];
  };
}
