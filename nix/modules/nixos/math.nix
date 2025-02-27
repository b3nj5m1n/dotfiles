{pkgs, ...}: {
  imports = [
    # ./neovim.nix
    ./zsh.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      libqalculate # qalc cli
      stable.sage
      sagetex
      typst
      typstfmt
      typst-live
      tinymist
      websocat
      stable.typst-preview
      numbat
    ];
  };
}
