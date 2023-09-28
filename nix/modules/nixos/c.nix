{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      clang
      libclang
      cmake
      gcc
    ];
  };
}
