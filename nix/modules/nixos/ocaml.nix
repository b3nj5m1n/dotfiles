{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      ocaml
      opam
      dune_3
      ocamlPackages.odoc
      ocamlPackages.ocaml-lsp
      ocamlPackages.utop
      ocamlPackages.ocamlformat
    ];
  };
}
