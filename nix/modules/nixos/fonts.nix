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
      newcomputermodern
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.fira-mono
      nerd-fonts.ubuntu-mono
    ];
  };
}
