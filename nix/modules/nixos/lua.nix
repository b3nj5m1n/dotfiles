{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      lua
      luajit
      sumneko-lua-language-server
    ];
  };
}
