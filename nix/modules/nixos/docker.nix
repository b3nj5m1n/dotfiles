{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
    virtualisation.docker.enable = true;
    users.users.b3nj4m1n.extraGroups = [ "docker" ];
  };
}
