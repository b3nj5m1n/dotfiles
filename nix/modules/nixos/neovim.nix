{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      neovim
      luajitPackages.luarocks
      # tree-sitter
      # tree-sitter-grammars.tree-sitter-norg
    ];
    programs.neovim = {
      enable = true;
      withRuby = true;
      withPython3 = true;
      withNodeJs = true;
    };
  };
}
