{ pkgs, ... }:
let
  iosevka = import ./fonts/iosevka.nix { inherit pkgs; };
in
{
  environment.systemPackages = [
    pkgs.geist-font
    iosevka
  ];

  fonts.packages = with pkgs; [
    texlivePackages.playfair
  ];
}
