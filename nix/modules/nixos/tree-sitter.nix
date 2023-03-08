{ pkgs, ... }:
let
  system = pkgs.system;

  pkgs_treesitter = import (builtins.fetchGit {
    name = "tree-sitter-cli";
    url = "https://github.com/mrene/nixpkgs";
    ref = "refs/heads/tree-sitter-wrapper";
    rev = "32abfde77f08a75587ec16b18b25f23eb9a640ff";
   }) { inherit system; };
in {
  imports = [
  ];

  options = { };



  config = {
    environment.systemPackages = [
      pkgs_treesitter.tree-sitter.withAllGrammarSources
    ];
  };

}
