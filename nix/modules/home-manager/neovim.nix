{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  options = {};

  config = {
    home.packages = with pkgs; [luajitPackages.luarocks];
    home.sessionVariables.EDITOR = "nvim";
    programs.neovim.enable = true;
  };
}
