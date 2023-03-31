{ pkgs, lib, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    home.sessionVariables.EDITOR = "hx";
    programs.helix = {
      enable = true;
      settings = {
        theme = "catppuccin_macchiato";
        editor = {
          line-number = "relative";
          cursor-shape = {
            insert = "bar";
          };
          whitespace = {
            render = {
              tab = "all";
              newline = "all";
            };
          };
          indent-guides = {
            render = true;
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
