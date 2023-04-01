{
  pkgs,
  lib,
  ...
}: {
  imports = [
  ];

  options = {};

  config = {
    programs.git = {
      enable = true;
      userEmail = "b3nj4m1n@gmx.net";
      userName = "b3nj5m1n";
      aliases = {
        pr = "!f() { git fetch -fu \${2:-origin} refs/pull/\$1/head:pr/\$1 && git checkout pr/\$1; }; f"; # https://stackoverflow.com/a/14969986
      };
      difftastic = {enable = true;};
      signing = {
        signByDefault = true;
      };
    };
  };
}
