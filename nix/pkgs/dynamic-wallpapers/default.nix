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

  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "dynamic-wallpaper";
    rev = ref;
    sha256 = "sha256-Tq4m4MnUMVt3PzKsWtIp5s01XOv3cs+eW4U8VQZ4OlA=";
  };
  # src = fetchzip {
  #   url = "https://github.com/adi1090x/dynamic-wallpaper/archive/${ref}.zip";
  #   sha256 = "sha256-Tq4m4MnUMVt3PzKsWtIp5s01XOv3cs+eW4U8VQZ4OlA=";
  #   stripRoot = false;
  # };

  nativeBuildInputs = with pkgs; [];

  installPhase = ''
    runHook preInstall
    ls
    mkdir -p "$out"
    cp -r ./images "$out/images"
    runHook postInstall
  '';
}
