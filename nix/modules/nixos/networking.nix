{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      iwd
      nmap
      wireguard-tools
    ];
    networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
    networking.networkmanager.wifi.backend = "iwd";
    networking.nftables.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [22 30021];
    };
  };
}
