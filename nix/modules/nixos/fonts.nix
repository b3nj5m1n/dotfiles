{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    # fonts.enableDefaultPackages = true;
    fonts.packages = with pkgs; [
      arkpandora_ttf
      liberation_ttf
      xits-math
      (nerdfonts.override {fonts = ["FantasqueSansMono" "FiraCode" "UbuntuMono"];})
    ];
  };
}
