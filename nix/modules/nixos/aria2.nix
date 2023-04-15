{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      aria
      aria_ng
    ];
    systemd.services.aria_ng = {
      enable = true;
      description = "Server aria_ng";
      path = [pkgs.static-web-server];
      unitConfig = {
        Type = "simple";
      };
      serviceConfig = {
        ExecStart = "${pkgs.static-web-server}/bin/static-web-server -p 30020 -d ${pkgs.aria_ng}";
      };
      wantedBy = ["multi-user.target"];
    };
    networking.firewall.allowedTCPPorts = [30020 30019];
    services.aria2 = {
      enable = true;
      openPorts = true;
      rpcListenPort = 30019;
    };
  };
}
