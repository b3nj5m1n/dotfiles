{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
    ];
    services.radicale = {
      enable = true;
      settings = {
        server = {
          hosts = ["0.0.0.0:5232" "[::]:5232"];
        };
        storage = {
          filesystem_folder = "/var/lib/radicale/collections";
        };
        auth = {
          type = "none";
          # htpasswd_filename = "/etc/radicale/users";
          # htpasswd_encryption = "bcrypt";
        };
      };
    };
    networking.firewall.allowedTCPPorts = [5232];
    networking.firewall.allowedUDPPorts = [5232];
  };
}
