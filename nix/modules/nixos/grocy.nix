{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
    ];
    virtualisation.oci-containers.containers.grocy = {
      image = "lscr.io/linuxserver/grocy:latest";
      ports = ["9283:80"];
      environment = {
        PUID = "1000";
        PGID = "1000";
        TZ = "Etc/UTC";
      };
      autoStart = true;
      volumes = [
        "config:/config"
      ];
    };
    /*
       services.grocy = {
        enable = true;
        hostName = "0.0.0.0";
        settings = {
            currency = "EUR";
            culture = "de";
            calendar = {
                firstDayOfWeek = 1;
            };
        };
    };
    */
    networking.firewall.allowedTCPPorts = [9283];
    networking.firewall.allowedUDPPorts = [9283];
  };
}
