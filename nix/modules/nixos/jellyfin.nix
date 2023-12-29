{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    services.jellyfin.enable = true;
    networking.firewall.allowedTCPPorts = [8096];
    networking.firewall.allowedUDPPorts = [8096];
  };
}
