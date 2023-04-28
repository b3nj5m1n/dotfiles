{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
    virtualisation.docker.enable = true;
  };
}
