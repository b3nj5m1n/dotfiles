{pkgs, ...}: {
  imports = [
    ./lua.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      luaPackages.fennel
      fnlfmt
      # fennel-language-server
    ];
  };
}
