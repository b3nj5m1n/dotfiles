{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      texlive.combined.scheme-full
      texlab
      ltex-ls
    ];
  };
}
