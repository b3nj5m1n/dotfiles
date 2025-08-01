{
  pkgs,
  lib,
  ...
}: {
  imports = let
    homeManagerModules = import ./.;
  in [
    homeManagerModules.ghostty
  ];

  options = {};

  config = {
  };
}
