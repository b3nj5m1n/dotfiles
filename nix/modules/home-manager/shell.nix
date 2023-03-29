{ pkgs, lib, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    programs = {
      zsh = {
        enable = true;
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}
