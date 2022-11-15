{ pkgs, ... }:
{
  imports = [
    ./webdev.nix
    ./javascript.nix
    ./typescript.nix
    ./elm.nix
    ./haskell.nix
    ./bash.nix
    ./java.nix
    ./lua.nix
    ./fennel.nix
    ./rust.nix
    ./nix.nix
    ./c.nix
    ./common-lisp.nix
    ./python.nix
  ];
}
