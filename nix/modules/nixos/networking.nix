{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      iwd
    ];
    networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
    networking.networkmanager.wifi.backend = "iwd";
    networking.firewall.enable = false;
  };
}
