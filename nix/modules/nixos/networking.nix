{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      iwd
      iwgtk
      nmap
      wpa_supplicant_gui
      wireguard-tools
      openconnect # VPN client compatible with anyconnect protocol
      networkmanagerapplet
    ];
    networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
    # networking.networkmanager.wifi.backend = "iwd";
    programs.nm-applet.enable = true;
    networking.nftables.enable = true;
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [22 30021];
    };
    networking.wireless.userControlled.enable = true;
    # networking.wireless.enable = true;
    networking.wireless.extraConfig = ''

    '';
  };
}
