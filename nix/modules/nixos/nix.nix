{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      rnix-lsp
    ];
  };
}
