{pkgs, ...}: {
  imports = [
  ];

  options = {};

  config = {
    environment.systemPackages = with pkgs; [
      nodejs
      typescript-language-server
      # nodePackages.parcel
      yarn
    ];
  };
}
