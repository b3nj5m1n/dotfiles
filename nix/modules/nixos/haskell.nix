{ pkgs, ... }:
{
  imports = [
  ];

  options = { };

  config = {
    environment.systemPackages = with pkgs; [
      cabal-install
      ghc
      haskell-language-server
    ];
  };
}
