{pkgs, ...}: let
  system = pkgs.system;

  pkgs_pandoc = import (builtins.fetchGit {
    name = "pandoc-2.13";
    url = "https://github.com/NixOS/nixpkgs/";
    ref = "refs/heads/nixpkgs-unstable";
    rev = "141439f6f11537ee349a58aaf97a5a5fc072365c";
  }) {inherit system;};
  # wrapper = pkgs_pandoc.lib.makeOverridable ({ } :
  #   pkgs.symlinkJoin {
  #     name = "pandoc";
  #     paths = [ pkgs_pandoc.pandoc ];
  #     buildInputs = [ pkgs.makeWrapper ];
  #     postBuild = ''
  #       wrapProgram "$out/bin/pandoc" --add-flags "--data-dir=/run/current-system/sw/share/pandoc/"
  #     '';
  #   });
in {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = [
      pkgs_pandoc.pandoc
      pkgs_pandoc.haskellPackages.pandoc-crossref
      pkgs_pandoc.haskellPackages.pandoc-include-code
      pkgs.texlive.combined.scheme-full
      pkgs.dasel
      pkgs.m4
    ];
  };
}
