{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = [
      # pkgs.jdt-language-server
      pkgs.openjdk
      pkgs.openjdk11
      pkgs.openjdk8
      (pkgs.writeShellScriptBin "jdtls" "${pkgs.jdt-language-server}/bin/jdt-language-server $@")
    ];
  };
}
