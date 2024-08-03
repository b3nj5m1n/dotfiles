{pkgs, ...}: {
  imports = [
    ./javascript.nix
    ./typescript.nix
    ./elm.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      /* nodePackages.vscode-css-languageserver-bin
      nodePackages.vscode-html-languageserver-bin */
      vscode-langservers-extracted
    ];
  };
}
