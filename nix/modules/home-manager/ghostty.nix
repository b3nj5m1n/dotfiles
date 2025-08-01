{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
  ];

  options = {};

  config = {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = {
        font-family = "FantasqueSans Mono";
        font-size = 15;
        window-decoration = false;
        theme = "catppuccin-macchiato";
      };
    };
  };
}
