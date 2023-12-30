{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  pkgs,
  fetchzip,
}:
stdenv.mkDerivation rec {
  pname = "swaylock-plugin";
  version = "0.0.1";
  ref = "9a267f3e4570edf4b2e52f35dec233e5922475d0";

  src = fetchFromGitHub {
    owner = "mstoeckl";
    repo = "swaylock-plugin";
    rev = ref;
    sha256 = "sha256-Fl2XbRkapXGLSP5lX3pDOhjpA7Pc9Ht4VJuZCtIrubE=";
  };

  nativeBuildInputs = with pkgs; [meson wayland wayland-protocols libxkbcommon cairo gdk-pixbuf pam pkg-config ninja scdoc];

  mesonFlags = [
    "-Dpam=enabled"
    "-Dgdk-pixbuf=enabled"
    "-Dman-pages=enabled"
  ];

  /*
     installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    mkdir -p "$out/etc/pam.d"
    cp ./swaylock-plugin "$out/bin/"
    echo "auth include login" > "$out/etc/pam.d/swaylock-plugin"
    runHook postInstall
  '';
  */
}
