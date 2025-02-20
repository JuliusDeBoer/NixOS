{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs.terraform.enable = true;
  programs.nixfmt.enable = true;
  programs.shfmt.enable = true;
}
