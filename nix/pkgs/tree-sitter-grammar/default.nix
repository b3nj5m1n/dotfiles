# This will put the generated parser in /run/current-system/sw/share/ts-grammars
# I tried to make this generic but it will probably only work for neorg without some extra work
{ lang-name
, repo-owner
, repo-name
, repo-version
, repo-rev
, repo-sha
, lib
, stdenvNoCC
, fetchFromGitHub
, makeWrapper
, pkgs
}:

stdenvNoCC.mkDerivation rec {
  pname = repo-name;
  version = repo-version;

  src = fetchFromGitHub {
    owner = repo-owner;
    repo = repo-name;
    rev = repo-rev;
    sha256 = repo-sha;
  };

  nativeBuildInputs = with pkgs; [ tree-sitter nodejs ];

  installPhase = ''
    runHook preInstall
    install -Dm644 grammar.js -t "$out/share/ts-grammars/${pname}"
    install -Dm644 package.json -t "$out/share/ts-grammars/${pname}"
    cd $out/share/ts-grammars/${pname}
    tree-sitter generate
    runHook postInstall
  '';
}
