# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  pfui = pkgs.callPackage ./pfui { };
  bemoji = pkgs.callPackage ./bemoji { };
  wofi-calc = pkgs.callPackage ./wofi-calc { };
  tree-sitter-norg = pkgs.callPackage ./tree-sitter-grammar {
    lang-name = "norg";
    repo-owner = "nvim-neorg";
    repo-name = "tree-sitter-norg";
    repo-version = "0.1.0";
    repo-rev = "dfac5ad2740a79b18ae849590a924e7bad3f1b23";
    repo-sha = "sha256-nH9Y2mYXRehqvq0kp1DkoI2dIAaCidFAxlKos8wZmks=";
  };
}
