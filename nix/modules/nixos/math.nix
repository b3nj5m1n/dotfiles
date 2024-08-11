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
      typst
      typst-lsp
      typstfmt
      typst-live
      tinymist
      websocat
      stable.typst-preview
    ];
  };
}
