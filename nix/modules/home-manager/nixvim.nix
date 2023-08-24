{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  options = {};

  config = {
    home.sessionVariables.EDITOR = "nvim";
    programs.nixvim = {
      enable = true;
      colorschemes.catppuccin = {
      	enable = true;
	flavour = "macchiato";
      };
    };
  };
}
