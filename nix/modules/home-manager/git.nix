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
      settings = {
        alias = {
          pr = "!f() { git fetch -fu \${2:-origin} refs/pull/\$1/head:pr/\$1 && git checkout pr/\$1; }; f"; # https://stackoverflow.com/a/14969986
        };
        user.email = "b3nj4m1n@gmx.net";
        user.name = "b3nj5m1n";
        init.defaultBranch = "main";
      };
      signing = {
        signByDefault = true;
      };
    };
    programs.difftastic = {
      enable = true;
      git.enable = true;
    };
  };
}
