{ pkgs, lib, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    home.packages = with pkgs; [ gtk-engine-murrine ];
    gtk = {
      enable = true;
      theme = {
        name = "Colloid-Dark";
        package = pkgs.colloid-gtk-theme;
      };
      cursorTheme = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 24;
      };
      iconTheme = {
        name = "Colloid";
        package = pkgs.colloid-icon-theme;
      };
    };
    home.pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Ice";
      size = 24;
    };
    xdg.dataFile."icons/default/index.theme".text = ''
      [icon theme]
      Name=Default
      Comment=Default Cursor Theme
      Inherits=Bibata-Original-Classic
    '';
  };
}
