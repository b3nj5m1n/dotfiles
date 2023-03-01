{ lib, stdenvNoCC, fetchFromGitHub, makeWrapper, pkgs, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "eisvogel";
  version = "2.2.0";

  # src = fetchFromGitHub {
  #   owner = "Wandmalfarbe";
  #   repo = "pandoc-latex-template";
  #   rev = "v${version}";
  #   sha256 = "sha256-5/xKGleBuyL+F1l7FnXkDMZT+wcpDve83BeoRkpDt18=";
  # };
  src = fetchzip {
    url = "https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v2.2.0/Eisvogel.tar.gz";
    sha256 = "sha256-rGX4GyPk2HcGfilmtz3l61tF0l3GHCSEhuzFLifrxHU=";
    stripRoot = false;
  };

  nativeBuildInputs = with pkgs; [  ];

  installPhase = ''
    runHook preInstall
    # tar xf Eisvogel.tar.gz
    install -Dm644 eisvogel.latex "$out/share/pandoc/templates/eisvogel.latex"
    runHook postInstall
  '';
}
