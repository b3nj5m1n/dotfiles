{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  pkgs,
  fetchzip,
}:
pkgs.buildNpmPackage rec {
  pname = "homepage";
  version = "0.6.16";

  # src = ./.;
  # src = fetchzip {
  #   url = "https://github.com/benphelps/homepage/archive/refs/tags/v0.6.16.tar.gz";
  #   sha256 = "sha256-CUq1nTyQK84pKbj1pQfW0m+8kuABWnE0DyaJr0DhxEk=";
  #   # stripRoot = false;
  # };
  src = fetchFromGitHub {
    owner = "benphelps";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-38ISnMxov7tZ6TeTZ+yDrFcKE289rwaR1VABKF+J++g=";
  };

  nativeBuildInputs = with pkgs; [python39];

  npmDepsHash = "sha256-O6SQYx5vxscMsbWv0ynUYqdUkOp/nMtdvlZ/Mp95sBY=";

  # The prepack script runs the build script, which we'd rather do in the build phase.
  npmPackFlags = ["--ignore-scripts"];

  NODE_OPTIONS = "--openssl-legacy-provider";

  preBuild = ''
    mkdir -p config
  '';

  installPhase = ''
    mkdir -p $out/share/homepage/config/logs
    cp -r ./.next/standalone/. $out/share/homepage/
    cp -r ./src/skeleton/* $out/share/homepage/config/
    cp -r ./.next/static/ $out/share/homepage/.next/
    touch $out/share/homepage/config/logs/homepage.log
  '';
}
