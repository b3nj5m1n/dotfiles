{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      python2
      python3
      python310Packages.jedi-language-server
    ];
  };
}
