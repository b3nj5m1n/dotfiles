{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      bash
      bash-language-server
      shellcheck
    ];
  };
}
