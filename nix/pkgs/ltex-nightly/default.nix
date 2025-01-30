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
  version = "15.5.0-alpha.nightly.2025-01-13";

  src = fetchurl {
    url = "https://github.com/ltex-plus/vscode-ltex-plus/releases/download/nightly/vscode-ltex-plus-15.5.0-alpha.nightly.2025-01-13-offline-linux-aarch64.vsix";
    sha256 = "sha256-UaWRX/1yZPkbewRhAQAyO8ZqvmDzrAkTCJ/7q5EUB00=";
  };

  nativeBuildInputs = [ makeBinaryWrapper unzip tree ];
  phases = [ "installPhase" ]; # Removes all phases except installPhase

  installPhase = ''
    runHook preInstall
    cp $src .
    tree
    unzip 7vlldsd5rn6ljdm0n90smy0f8pg07dfj-vscode-ltex-plus-15.5.0-alpha.nightly.2025-01-13-offline-linux-aarch64.vsix

    cd extension/lib/ltex-ls-plus-18.5.0-alpha.nightly.2025-01-13
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
