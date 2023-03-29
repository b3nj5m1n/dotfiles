{ pkgs, lib, config, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    programs.gpg = {
      enable = true;
      homedir = "${config.xdg.dataHome}/gnupg";
      settings = { };
    };
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "gtk2";
      extraConfig = ''
      '';
    };
  };
}
