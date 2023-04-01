{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  makeWrapper,
  pkgs,
}:
stdenvNoCC.mkDerivation rec {
  pname = "bemoji";
  version = "0.3.0";

  src = fetchFromGitHub {
    owner = "marty-oehme";
    repo = pname;
    rev = version;
    sha256 = "sha256-XXNrUaS06UHF3cVfIfWjGF1sdPE709W2tFhfwTitzNs=";
  };

  nativeBuildInputs = with pkgs; [makeWrapper wofi wl-clipboard wtype];

  installPhase = ''
    runHook preInstall
    install -Dm755 bemoji "$out/share/bemoji/bemoji.sh"
    install -Dm644 assets/* -t "$out/share/bemoji/assets"

    mkdir -p "$out/bin"
    ln -s "$out/share/bemoji/bemoji.sh" "$out/bin/bemoji"
    wrapProgram "$out/bin/bemoji" \
      --prefix PATH : "${lib.makeBinPath (with pkgs; [wofi wl-clipboard wtype])}"

    runHook postInstall
  '';
}
