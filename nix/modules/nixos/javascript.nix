{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      nodePackages.npm
      nodePackages.typescript-language-server
      nodePackages.parcel
      stable.nodejs
      yarn
    ];
  };
}
