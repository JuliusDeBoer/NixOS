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
      url = "github:JuliusDeBoer/HellComp/refs/tags/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      overlay = final: prev: {
        hellcomp = inputs.hellcomp.packages."${system}".default;
        zen = inputs.zen-browser.packages."${system}".default;
      };

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = false;
        };
      };
    in
    {
      nixosConfigurations.T480 = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        inherit system;
        modules = [
          ./configuration.nix
          ./hosts/T480.nix
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
      formatter.${system} =
        (inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.wrapper;
        checks.${system} =
        (inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix).config.build.check self;
      devShell.${system} = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixd
          nil
        ];
      };
    };
}
