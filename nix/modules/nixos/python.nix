{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      python3
      python312Packages.jedi-language-server
      python312Packages.python-lsp-server
      poetry
      pipx
      python311Packages.bpython
    ];
  };
}
