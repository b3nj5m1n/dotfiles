# flake.nix
{
  inputs = {
    pkgs-stable.url = "github:NixOS/nixpkgs/release-22.05";
    pkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "pkgs-unstable";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "pkgs-unstable";
    };
  };

  outputs = { self, pkgs-stable, pkgs-unstable, home-manager, hyprland, ... }@inputs:
    let
      system = "x86_64-linux";
      overlays = [
        (final: prev: {
                  stable = import inputs.pkgs-stable { system = final.system; };
                  unstable = import inputs.pkgs-unstable { system = final.system; };
              }
        )
      ];
      pkgs = import pkgs-stable {
        inherit system;
        inherit overlays;
      };
      lib = pkgs-unstable.lib;
    in {
      nixosConfigurations =  {
        nixpad = lib.nixosSystem {
	      inherit system;
          specialArgs = { inherit overlays; };
          modules = [
	        ./configuration.nix
	        home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
	          home-manager.useUserPackages = true;
	          home-manager.users.b3nj4m1n = import ./home.nix;
	        }
            hyprland.nixosModules.default
            { programs.hyprland.enable = true; }
          ];
        };
      };
    };
}
