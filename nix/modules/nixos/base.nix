{ pkgs, ... }:
{
  imports = [
    ./networking.nix
    ./security.nix
  ];

  options = { };

  config = {
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_GB.UTF-8";
    environment.pathsToLink = [ "/share" ];
    services.cron.enable = true;
  };
}
