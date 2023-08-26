{
  stdenv,
  pkgs,
  fetchFromGitHub,
  rustPlatform,
  ...
}: rustPlatform.buildRustPackage rec {
    pname = "fennel-language-server";
    version = "0.1.0";

    src = fetchFromGitHub {
      owner = "rydesun";
      repo = pname;
      rev = "d0c65db2ef43fd56390db14c422983040b41dd9c";
      hash = "sha256-KU2MPmgHOS/WesBzCmEoHHXHoDWCyqjy49tmMmZw5BQ=";
    };

    cargoSha256 = "sha256-yYjs7vwKSTriTjUrvKECDyLWVkN1EMrYuPiI3c5lY5U=";
    verifyCargoDeps = true;

  }
