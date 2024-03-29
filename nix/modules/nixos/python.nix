{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      python3
      python310Packages.jedi-language-server
      python310Packages.python-lsp-server
      poetry
      pipx
      python311Packages.bpython
    ];
  };
}
