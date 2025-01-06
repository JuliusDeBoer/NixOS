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
      url = "github:0xc000022070/zen-browser-flake/cea051b6f908304f4af6484b14a532c729f0cc34";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hellcomp = {
      url = "github:JuliusDeBoer/HellComp/refs/tags/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";

      overlay = final: prev: {
        hellcomp = inputs.hellcomp.packages."${system}".default;
        zen = inputs.zen-browser.packages."${system}".default;
        ghostty = inputs.ghostty.packages."${system}";
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
