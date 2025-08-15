{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hellcomp = {
      url = "github:JuliusDeBoer/HellComp";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    stylix.url = "github:danth/stylix";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      overlay = final: prev: {
        hellcomp = inputs.hellcomp.packages."${system}".default;
      };

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = false;
        };
      };

      treefmt_config = (inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config;
    in
    {
      nixosConfigurations = {
        T480 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          inherit system;
          modules = [
            ./configuration.nix
            ./hosts/T480.nix
            inputs.stylix.nixosModules.stylix
            inputs.spicetify-nix.nixosModules.default
            inputs.home-manager.nixosModules.default
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  inputs.rust-overlay.overlays.default
                  overlay
                ];
              }
            )
          ];
        };
        win = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
          };
          inherit system;
          modules = [
            inputs.stylix.nixosModules.stylix
            inputs.home-manager.nixosModules.default
            ./modules/shell.nix
            ./modules/git.nix
            (
              { ... }:
              {
                nixpkgs.overlays = [
                  inputs.rust-overlay.overlays.default
                  overlay
                ];
              }
            )
          ];
        };
      };
      formatter.${system} = treefmt_config.build.wrapper;
      checks.${system} = {
        formatting = treefmt_config.build.check self;
      };
      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixd
          nil
        ];
      };
    };
}
