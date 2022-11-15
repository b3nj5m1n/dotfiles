# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example' or (legacy) 'nix-build -A example'

{ pkgs ? (import ../nixpkgs.nix) { } }: {
  pfui = pkgs.callPackage ./pfui { };
  bemoji = pkgs.callPackage ./bemoji { };
  wofi-calc = pkgs.callPackage ./wofi-calc { };
}
