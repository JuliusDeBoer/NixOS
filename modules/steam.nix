{ config, pkgs, ... }:

let
  protonGE = pkgs.stdenv.mkDerivation rec {
    # TODO: Figure out how to auto enable proton for all video games
    name = "proton-ge-custom";

    src = fetchTarball {
      url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton9-11/GE-Proton9-11.tar.gz";
      sha256 = "0ymmzjmpywlr9pd5y326xh8l43wh6vz6yv58qn2wdz4ikr3j0srq";
    };

    # TODO: Use the xdg variables for this?
    installPhase = ''
      mkdir -p $out
      cp -r * $out
    '';
  };
in
{
  programs.steam.enable = true;

  home-manager.users.julius =
    { pkgs, ... }:
    {
      home.packages = [
        protonGE
      ];

      home.file.".steam/root/compatibilitytools.d/${protonGE.name}".source = "${protonGE}";
    };
}
