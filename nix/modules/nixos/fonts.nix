{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    fonts.fonts = with pkgs; [
      arkpandora_ttf
      liberation_ttf
      (nerdfonts.override {fonts = ["FantasqueSansMono" "FiraCode" "UbuntuMono"];})
    ];
  };
}
