{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  pkgs,
  fetchzip,
}:
stdenv.mkDerivation rec {
  pname = "dynamic-wallpapers";
  version = "0.0.1";
  ref = "de6bc647b4a8aa459bbc6dc8fc411569bec7ac44";

  src = fetchzip {
    url = "https://github.com/adi1090x/dynamic-wallpaper/archive/${ref}.zip";
    sha256 = "sha256-dLjNYuMvbJ+IZWVvM1ARBZvaGp7CNbSLmV4gX1OUTsI=";
    stripRoot = true;
  };

  nativeBuildInputs = with pkgs; [];

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -r ./dynamic-wallpaper-${ref}/images "$out/images"
    runHook postInstall
  '';
}
