{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      elmPackages.elm
      elmPackages.elm-language-server
      elmPackages.elm-format
    ];
  };
}
