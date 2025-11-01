{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      lua
      luajit
      lua-language-server
    ];
  };
}
