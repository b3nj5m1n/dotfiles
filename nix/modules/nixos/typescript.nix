{pkgs, ...}: {
  imports = [
    ./javascript.nix
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      deno
      nodePackages.typescript
      nodePackages.typescript-language-server
      nodePackages.parcel
    ];
  };
}
