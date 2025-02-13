{
  lib,
  stdenvNoCC,
  fetchurl,
  fetchzip,
  makeBinaryWrapper,
  jre_headless,
  unzip,
  tree,
}:

stdenvNoCC.mkDerivation rec {
  pname = "ltex-nightly";
  version = "15.5.0-alpha.nightly.2025-02-03";

  src = fetchurl {
    url = "https://github.com/ltex-plus/vscode-ltex-plus/releases/download/nightly/vscode-ltex-plus-${version}-offline-linux-aarch64.vsix";
    sha256 = "sha256-ivht8uGVAJIRY6CgOJG92UKLdpsJJFRR1C4y6yuaBR0=";
  };

  nativeBuildInputs = [ makeBinaryWrapper unzip tree ];
  phases = [ "installPhase" ]; # Removes all phases except installPhase

  installPhase = ''
    runHook preInstall
    cp $src .
    tree
    unzip k270c17ll44sdbg2drq8qcv8zpnz92b5-vscode-ltex-plus-${version}-offline-linux-aarch64.vsix
    tree

    cd extension/lib/ltex-ls-plus-18.5.0-alpha.nightly.2025-02-03
    mkdir -p $out
    cp -rfv bin/ lib/ $out
    rm -fv $out/bin/.lsp-cli.json $out/bin/*.bat
    for file in $out/bin/{ltex-ls-plus,ltex-cli-plus}; do
      wrapProgram $file --set JAVA_HOME "${jre_headless}"
    done

    runHook postInstall
  '';

  meta =
    let
      inherit (lib) licenses maintainers;
    in
    {
      homepage = "https://ltex-plus.github.io/ltex-plus/";
      description = "LSP language server for LanguageTool";
      license = licenses.mpl20;
      mainProgram = "ltex-cli-plus";
      maintainers = [ maintainers.FirelightFlagboy ];
      platforms = jre_headless.meta.platforms;
    };
}
