{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      postgresql
      pr229184.pgadmin
    ];
    services.postgresql = {
      package = pkgs.postgresql;
    };
    # services.pgadmin = {
    #   enable = true;
    #   initialEmail = "b3nj4m1n@gmx.net";
    #   initialPasswordFile = let
    #     pw_file = pkgs.writeTextFile {
    #       name = "pgadmin-password";
    #       text = ''
    #         123456
    #       '';
    #     };
    #   in "${pw_file}";
    # };
  };
}
