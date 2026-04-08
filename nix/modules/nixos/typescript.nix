{pkgs, ...}: {
  imports = [
    ./javascript.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      deno
      typescript
      typescript-language-server
      # nodePackages.parcel
    ];
  };
}
