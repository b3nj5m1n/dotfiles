{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      clang
      clang-tools
      # libclang
      cmake
      gcc
    ];
  };
}
