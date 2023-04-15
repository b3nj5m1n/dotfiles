{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      aria
    ];
    services.aria2 = {
      enable = true;
      openPorts = true;
      rpcListenPort = 30019;
    };
  };
}
