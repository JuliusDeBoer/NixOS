{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.geist-font
  ];
  fonts.packages = with pkgs; [
    texlivePackages.playfair
  ];
}
