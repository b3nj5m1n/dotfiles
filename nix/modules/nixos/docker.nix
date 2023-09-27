{
  pkgs,
  user,
  ...
}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];
    virtualisation.docker.enable = true;
    users.users."${user}".extraGroups = ["docker"];
  };
}
