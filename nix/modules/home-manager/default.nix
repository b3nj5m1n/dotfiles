{
  neovim = import ./neovim.nix;
  helix = import ./helix.nix;
  tree-sitter = import ./tree-sitter.nix;
  theming = import ./theming.nix;
  gpg = import ./gpg.nix;
  git = import ./git.nix;
  shell = import ./shell.nix;
  xdg-compliance = import ./xdg-compliance.nix;
  hyprland = import ./hyprland.nix;
  waybar = import ./waybar.nix;
  ghostty = import ./ghostty.nix;
  desktop = import ./desktop.nix;
  sway = import ./sway.nix;
}
