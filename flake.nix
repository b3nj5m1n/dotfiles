{
  description = "Your new nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    sops-nix.url = "github:Mic92/sops-nix";

    hardware.url = "github:nixos/nixos-hardware";

    xremap-flake.url = "github:xremap/nix-flake";

    dwarffs.url = "github:edolstra/dwarffs";

    pfui.url = "github:b3nj5m1n/pfui";

    # nixos-cosmic = {
    #   url = "github:lilyinstarlight/nixos-cosmic";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs =
    {
      self,
      fenix,
      nixpkgs,
      home-manager,
      # hyprland,
      flake-utils,
      sops-nix,
      dwarffs,
      pfui,
      # nixos-cosmic,
      # ghostty,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
        # "i686-linux"
        # "aarch64-darwin"
        # "x86_64-darwin"
      ];
    in
    rec {
      # Custom packages
      packages = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./nix/pkgs {
          inherit pkgs;
          inherit system;
          inherit fenix;
          inherit pfui;
          # inherit ghostty;
        }
      );

      # Devshell for bootstrapping
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./nix/shell.nix { inherit pkgs; }
      );

      apps = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          format = flake-utils.lib.mkApp {
            drv = pkgs.writeShellApplication {
              name = "format";
              meta = with nixpkgs.lib; {
                description = "Check formatting of nix files of this repository";
                platforms = platforms.all;
              };
              runtimeInputs = [ pkgs.alejandra ];
              text = ''
                alejandra --check .
              '';
            };
          };
        }
      );

      # Custom packages and modifications, exported as overlays
      overlays = import ./nix/overlays {
        inherit inputs;
        inherit fenix;
        inherit pfui;
        # inherit ghostty;
        # inherit hyprland;
      };
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./nix/modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./nix/modules/home-manager;

      nixosConfigurations = {
        adelie = nixpkgs.lib.nixosSystem {
          # I know it's Adélie
          specialArgs = { inherit inputs outputs; };
          modules = [
            outputs.nixosModules.base
            outputs.nixosModules.shared-repos
            outputs.nixosModules.terminal
            outputs.nixosModules.sway
            outputs.nixosModules.all-languages
            # (outputs.nixosModules args).pandoc
            outputs.nixosModules.aria2
            outputs.nixosModules.battery-thing
            outputs.nixosModules.pix2tex
            # (outputs.nixosModules args).steam
            outputs.nixosModules.math
            {
              # nix.settings = {
              #   substituters = ["https://cosmic.cachix.org/"];
              #   trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
              # };
            }
            # nixos-cosmic.nixosModules.default
            # dwarffs.nixosModules.dwarffs
            ./nix/nixos/adelie.nix
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."b3nj4m1n" = {
                imports = [
                  ./nix/home-manager/adelie.nix
                ];
              };
            }
          ];
        };
        emperor = nixpkgs.lib.nixosSystem {
          # Desktop
          specialArgs = { inherit inputs outputs; };
          modules = [
            outputs.nixosModules.base
            outputs.nixosModules.shared-repos
            outputs.nixosModules.terminal
            outputs.nixosModules.sway
            outputs.nixosModules.all-languages
            outputs.nixosModules.android
            # (outputs.nixosModules args).pandoc
            outputs.nixosModules.steam
            outputs.nixosModules.gitega
            outputs.nixosModules.virtual-machines
            outputs.nixosModules.tree-sitter
            # (outputs.nixosModules args).nvidia
            outputs.nixosModules.fix-suspend
            outputs.nixosModules.open-rgb
            (outputs.nixosModules.docker {
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
              user = "b3nj4m1n";
            })
            outputs.nixosModules.encryption
            outputs.nixosModules.aria2
            outputs.nixosModules.postgres
            outputs.nixosModules.pix2tex
            outputs.nixosModules.math
            # (outputs.nixosModules args).jellyfin # TODO
            outputs.nixosModules.radicale
            outputs.nixosModules.grocy
            {
              # nix.settings = {
              #   substituters = ["https://cosmic.cachix.org/"];
              #   trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
              # };
            }
            # nixos-cosmic.nixosModules.default
            ./nix/nixos/emperor.nix
            sops-nix.nixosModules.sops
            # hyprland.nixosModules.default
            # {programs.hyprland.enable = true;}
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.sharedModules = [
                # hyprland.homeManagerModules.default
              ];
              home-manager.users."b3nj4m1n" = {
                imports = [
                  ./nix/home-manager/emperor.nix
                ];
              };
            }
            inputs.xremap-flake.nixosModules.default
            {
              services.xremap = {
                # userName = "b3nj4m1n";
                # serviceMode = "user";
                withWlroots = true;
                # withSway = true;
                yamlConfig = ''keymap:'';
                # yamlConfig = ''
                #   keymap:
                #       - name: Test
                #         remap:
                #           C-b: { with_mark: left }
                #         device:
                #             only: '/dev/input/event10'
                #   '';
              };
            }
          ];
        };
        chinstrap = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs; };
          modules = [
            outputs.nixosModules.base
            outputs.nixosModules.shell
            outputs.nixosModules.bash
            outputs.nixosModules.nix
            outputs.nixosModules.python
            outputs.nixosModules.jellyfin
            outputs.nixosModules.aria2
            (outputs.nixosModules.docker {
              pkgs = nixpkgs.legacyPackages.aarch64-linux;
              user = "admin";
            })
            ./nix/nixos/chinstrap.nix
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."admin" = {
                imports = [
                  ./nix/home-manager/chinstrap.nix
                ];
              };
            }
          ];
        };
      };

      homeConfigurations = {
        "b3nj4m1n@adelie" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./nix/home-manager/adelie.nix
          ];
        };
        "b3nj4m1n@emperor" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./nix/home-manager/emperor.nix
          ];
        };
        "admin@chinstrap" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [
            ./nix/home-manager/chinstrap.nix
          ];
        };
      };
    };
}
