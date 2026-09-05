{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      texliveFull
      texlab
      # ltex-ls-plus
    ];
  };
}
