# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.

{
  # Base module with stuff I want everywhere
  base = ./base.nix;
  networking = ./networking.nix;
  security = ./security.nix;

  # Terminal stuff
  shell = import ./shell.nix;
  zsh = import ./zsh.nix;
  neovim = import ./neovim.nix;
  terminal = import ./terminal.nix;

  # Desktop stuff
  desktop = ./desktop.nix;
  wayland = ./wayland.nix;
  sway = ./sway.nix;
  fonts = ./fonts.nix;
  audio = ./audio.nix;

  # Languages
  all-languages = import ./all-languages.nix;
  webdev = import ./webdev.nix;
  javascript = import ./javascript.nix;
  typescript = import ./typescript.nix;
  elm = import ./elm.nix;
  haskell = import ./haskell.nix;
  bash = import ./bash.nix;
  java = import ./java.nix;
  lua = import ./lua.nix;
  fennel = import ./fennel.nix;
  rust = import ./rust.nix;
  nix = import ./nix.nix;
  c = import ./c.nix;
  common-lisp = import ./common-lisp.nix;
}
