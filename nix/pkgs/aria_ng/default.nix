{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  pkgs,
  fetchzip,
}:
stdenv.mkDerivation rec {
  pname = "aria_ng";
  version = "1.3.4";

  src = fetchzip {
    url = "https://github.com/mayswind/AriaNg/releases/download/${version}/AriaNg-${version}.zip";
    sha256 = "sha256-JTJ/PAgpuMGIIBBqiCkWFcFu7a7GVpBvJ/HoRF+NGAk=";
    stripRoot = false;
  };

  nativeBuildInputs = with pkgs; [];

  installPhase = ''
    runHook preInstall
    mkdir -p "$out"
    cp -r * "$out/"
    runHook postInstall
  '';
}
