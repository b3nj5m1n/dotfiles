{ lib, stdenvNoCC, fetchFromGitHub, makeWrapper, pkgs }:

stdenvNoCC.mkDerivation rec {
  pname = "wofi-calc";
  version = "1.1";

  src = fetchFromGitHub {
    owner = "Zeioth";
    repo = pname;
    rev = version;
    sha256 = "sha256-TqxlVivyMITB2/sT84ywPwEN54kENBzJ/hQfUeSNTKY=";
  };

  nativeBuildInputs = with pkgs; [ makeWrapper wofi libqalculate ];

  installPhase = ''
    runHook preInstall
    install -Dm755 wofi-calc.sh "$out/share/wofi-calc/wofi-calc.sh"

    mkdir -p "$out/bin"
    ln -s "$out/share/wofi-calc/wofi-calc.sh" "$out/bin/wofi-calc"
    wrapProgram "$out/bin/wofi-calc" \
      --prefix PATH : "${lib.makeBinPath (with pkgs; [ wofi libqalculate ])}"

    runHook postInstall
  '';
}
