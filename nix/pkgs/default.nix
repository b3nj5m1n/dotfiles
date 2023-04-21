# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'
{
  pkgs ? (import ../nixpkgs.nix) {},
  system,
  fenix,
}: {
  # fenix = import fenix {inherit system;};
  rust-toolchain = fenix.packages.${system}.complete.toolchain;
  rust-analyzer-nightly = fenix.packages.${system}.rust-analyzer;
  pfui = pkgs.callPackage ./pfui {};
  eisvogel = pkgs.callPackage ./eisvogel {};
  # logseq-wrapped = pkgs.callPackage ./logseq-wrapped {};
  # logseq-wrapped = if system == "x86_64-linux" then pkgs.callPackage ./logseq-wrapped {} else null;
  # logseq-wrapped = lib.optional (system == "x86_64-linux") (pkgs.callPackage ./logseq-wrapped {});
  bemoji = pkgs.callPackage ./bemoji {};
  wofi-calc = pkgs.callPackage ./wofi-calc {};
  # tree-sitter-grammar = {
  #   norg = pkgs.callPackage ./tree-sitter-grammar {
  #     lang-name = "norg";
  #     repo-owner = "nvim-neorg";
  #     repo-name = "tree-sitter-norg";
  #     repo-version = "0.1.0";
  #     repo-rev = "dfac5ad2740a79b18ae849590a924e7bad3f1b23";
  #     repo-sha = "sha256-nH9Y2mYXRehqvq0kp1DkoI2dIAaCidFAxlKos8wZmks=";
  #   };
  # };
  aria_ng = pkgs.callPackage ./aria_ng {};
  dynamic-wallpapers = pkgs.callPackage ./dynamic-wallpapers {};
  homepage = pkgs.callPackage ./homepage {};
}
