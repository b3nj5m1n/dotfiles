{ pkgs, lib, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    programs.helix = {
      enable = true;
      settings = {
        theme = "catppuccin_macchiato";
        editor = {
          line-number = "relative";
          cursor-shape = {
            insert = "bar";
          };
        };
        keys = {
          normal = {
            esc = ["collapse_selection" "keep_primary_selection"];
          };
        };
      };
    };
  };
}
