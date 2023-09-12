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
  };
}
