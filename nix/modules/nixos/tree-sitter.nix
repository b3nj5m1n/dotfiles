{pkgs, ...}: let
  system = pkgs.system;

  pkgs_treesitter = import (builtins.fetchTarball {
    url = "https://github.com/mrene/nixpkgs/archive/refs/heads/tree-sitter-wrapper-test.tar.gz";
    sha256 = "sha256:0a3lkl75cw58mma780wcbi9xx4v14m9in9n9scdva1mpalbi69yg";
  }) {inherit system;};
in {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = [
      pkgs_treesitter.tree-sitter.withAllGrammarSources
    ];
  };
}
