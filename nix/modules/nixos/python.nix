{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      python3
      python314Packages.jedi-language-server
      python314Packages.python-lsp-server
      poetry
      # pipx
      # python311Packages.bpython
    ];
  };
}
