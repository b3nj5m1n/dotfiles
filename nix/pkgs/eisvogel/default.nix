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
    sed -i 's/pagenumbering{arabic}//g' eisvogel.latex # This makes title page count as page 1
    sed -i 's/\\begin{document}/\\begin{document}\n\\pagenumbering{Roman}/g' eisvogel.latex # This makes it use roman numberals for page counting before the main content
    install -Dm644 eisvogel.latex "$out/share/pandoc/templates/eisvogel.latex"
    runHook postInstall
  '';
}
