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
