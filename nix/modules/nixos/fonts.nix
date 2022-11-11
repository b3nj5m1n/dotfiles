{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    fonts.fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "FantasqueSansMono" "FiraCode" "UbuntuMono" ]; })
    ];
  };
}
