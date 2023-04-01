{pkgs, ...}: {
  imports = [
    ./networking.nix
    ./security.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      home-manager
    ];
    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_GB.UTF-8";
    environment.pathsToLink = ["/share" "/share/zsh"];
    services.cron.enable = true;
  };
}
