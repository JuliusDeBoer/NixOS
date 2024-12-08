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
      url = "github:MarceColl/zen-browser-flake/e6ab73f405e9a2896cce5956c549a9cc359e5fcc";
    };

    hellcomp.url = "github:JuliusDeBoer/HellComp/refs/tags/stable";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      overlay = final: prev: {
        hellcomp = inputs.hellcomp.packages."${system}".default;
        zen = inputs.zen-browser.packages."${system}";
      };

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
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
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixd
          nil
        ];
      };
    };
}
