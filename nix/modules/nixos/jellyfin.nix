{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    services.jellyfin.enable = true;
    networking.firewall.allowedTCPPorts = [30006];
    networking.firewall.allowedUDPPorts = [30006];
  };
}
