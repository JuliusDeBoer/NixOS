{ pkgs, ... }:
let
  iosevka = import ./fonts/iosevka.nix { inherit pkgs; };
in
{
  environment.systemPackages = [
    iosevka
    pkgs.geist-font
  ];

}
