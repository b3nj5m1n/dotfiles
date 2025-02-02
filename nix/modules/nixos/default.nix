# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  pkgs,
  user,
}: {
  # Base module with stuff I want everywhere
  base = import ./base.nix;
  networking = import ./networking.nix;
  security = import ./security.nix;
  shared-repos = import ./shared-repos.nix;

  # Terminal stuff
  shell = import ./shell.nix;
  zsh = import ./zsh.nix;
  neovim = import ./neovim.nix;
  terminal = import ./terminal.nix;

  # Desktop stuff
  desktop = import ./desktop.nix;
  wayland = import ./wayland.nix;
  sway = import ./sway.nix;
  fonts = import ./fonts.nix;
  audio = import ./audio.nix;

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
  python = import ./python.nix;
  latex = import ./latex.nix;
  ocaml = import ./ocaml.nix;

  # pandoc = import ./pandoc.nix;
  steam = import ./steam.nix;
  nvidia = import ./nvidia.nix;
  gitega = import ./gitega.nix;
  virtual-machines = import ./virtual-machines.nix;
  tree-sitter = import ./tree-sitter.nix;
  fix-suspend = import ./fix-suspend.nix;
  open-rgb = import ./open-rgb.nix;
  docker = import ./docker.nix {
    inherit pkgs;
    inherit user;
  };
  jellyfin = import ./jellyfin.nix;
  encryption = import ./encryption.nix;
  aria2 = import ./aria2.nix;
  dynamic-wallpaper = import ./dynamic-wallpaper.nix;
  android = import ./android.nix;
  postgres = import ./postgres.nix;
  battery-thing = import ./battery-thing.nix;
  pix2tex = import ./pix2tex.nix;
  math = import ./math.nix;
  swaylock-plugin = import ./swaylock-plugin.nix;
  radicale = import ./radicale.nix;
  grocy = import ./grocy.nix;
}
