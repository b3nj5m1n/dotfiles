{
  stdenv,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
  ...
}: let
  libPath = with pkgs;
    lib.makeLibraryPath [
      libpulseaudio
    ];
in
  rustPlatform.buildRustPackage rec {
    pname = "pfui";
    version = "0.1.0";

    src = fetchFromGitHub {
      owner = "b3nj5m1n";
      repo = pname;
      rev = version;
      hash = "sha256-SeTEGq0R3TthHbxC2/mZAk/Kvgjt13l7sw1tcje7Wxg=";
    };

    cargoSha256 = "sha256-T3EBNvTifHbn5Lh4owMlqpUSoL6vXLBVRbhHPzjBb0M=";
    verifyCargoDeps = true;

    nativeBuildInputs = [pkgs.makeWrapper];
    buildInputs = with pkgs; [
      libpulseaudio
    ];
    LD_LIBRARY_PATH = libPath;

    preConfigure = ''
      export HOME=$(mktemp -d)
    '';
    postInstall = ''
      wrapProgram "$out/bin/pfui" --prefix LD_LIBRARY_PATH : "${libPath}"
    '';
  }
