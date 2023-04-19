# This file defines overlays
{
  inputs,
  fenix,
  hyprland,
}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev:
    import ../pkgs {
      pkgs = final;
      system = prev.system;
      inherit fenix;
    };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    swww = prev.rustPlatform.buildRustPackage rec {
      pname = "swww";
      version = "0.7.2";

      src = prev.fetchFromGitHub {
        owner = "b3nj5m1n";
        repo = "swww";
        rev = "e0ada26825f243ce0a20110f13579ba803344a22";
        hash = "sha256-zJNkcykp3RCgxWj3Vo64Qw9IECa8dZ7P//HwW33vn2E=";
      };

      cargoSha256 = "sha256-TP5pjLtTNkcM8ipPl5VPRMO+510bsHtyaYXzxe99rCw=";
      buildInputs = with prev; [lz4 libxkbcommon];
      doCheck = false; # Integration tests do not work in sandbox environment
      nativeBuildInputs = with prev; [pkg-config];

      meta = with prev.lib; {
        description = "Efficient animated wallpaper daemon for wayland, controlled at runtime";
        homepage = "https://github.com/Horus645/swww";
        license = licenses.gpl3;
        maintainers = with maintainers; [mateodd25];
        platforms = platforms.linux;
      };
    };
    # swww = prev.swww.overrideAttrs (old: {
    #   src = prev.fetchFromGitHub {
    #     owner = "b3nj5m1n";
    #     repo = "swww";
    #     rev = "1711140520b4eb735e0f52f86a825e54e2d368ed";
    #     hash = "sha256-NZBmyXPUGuLdEyXit30oVFHzVgpHrK0q6lBJ+V/wd0I=";
    #   };
    #   # cargoSha256 = "sha256-TP5pjLtTNkcM8ipPl5VPRMO+510bsHtyaYXzxe99rCw=";
    #   cargoSha256 = "";
    # });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  channels = final: prev: {
    stable = import inputs.nixpkgs-stable {system = final.system;};
    unstable = import inputs.nixpkgs {system = final.system;};
  };

  hyprland = hyprland.overlays.default;
}
