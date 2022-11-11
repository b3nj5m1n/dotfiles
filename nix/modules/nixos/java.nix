{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      jdt-language-server
      openjdk
      openjdk11
      openjdk8
    ];
  };
}
