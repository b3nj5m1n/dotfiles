{
  helix = import ./helix.nix;
  tree-sitter = import ./tree-sitter.nix;
  theming = import ./theming.nix;
  gpg = import ./gpg.nix;
  git = import ./git.nix;
  shell = import ./shell.nix;
  xdg-compliance = import ./xdg-compliance.nix;
}
