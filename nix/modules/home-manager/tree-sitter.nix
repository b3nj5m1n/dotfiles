# Note that this module is for configuring treesitter for use in neovim, not for
# use with the tree-sitter cli
{ pkgs, lib, ... }:
let
  nvim-parser-location = "nvim/site/pack/packer/opt/nvim-treesitter/parser";
  # Conver the package name to the language name, for example:
  # pname-to-lname "tree-sitter-rust-grammar" -> "rust"
  pname-to-lname = pname:
    lib.strings.removeSuffix "-grammar" (lib.strings.removePrefix "tree-sitter-" pname);
  genLink = package-name:
    let
      package = pkgs.tree-sitter-grammars."${package-name}";
      language-name = pname-to-lname package.pname;
    in
    {
      "${nvim-parser-location}/${language-name}.so".source = "${package.outPath}/parser";
    };
  genLinks = language-names:
    lib.lists.foldl (a: b: a // b) { } (builtins.map genLink language-names);
  getAll = builtins.filter (x: builtins.isAttrs pkgs.tree-sitter-grammars."${x}") (builtins.attrNames pkgs.tree-sitter-grammars);
  genAll = genLinks getAll;
in
{
  imports = [
  ];

  options = { };

  config = {
    xdg.dataFile = genAll;
  };
}
