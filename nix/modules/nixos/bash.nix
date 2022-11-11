{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      bash
      nodePackages.bash-language-server
      shellcheck
    ];
  };
}
