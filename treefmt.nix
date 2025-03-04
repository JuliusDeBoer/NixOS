{ ... }:
{
  projectRootFile = "flake.nix";

  # TODO(Julius): Add XML support
  programs.terraform.enable = true;
  programs.nixfmt.enable = true;
  programs.shfmt.enable = true;
}
