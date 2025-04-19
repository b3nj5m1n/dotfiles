{pkgs, ...}: {
  imports = [
    ./lua.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      fennel
      fnlfmt
      # fennel-language-server
    ];
  };
}
