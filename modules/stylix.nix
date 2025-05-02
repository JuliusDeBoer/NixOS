{ pkgs, config, ... }:
let
  iosevka = import ./fonts/iosevka.nix { inherit pkgs; };
in
{

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";

    cursor = {
      name = "Banana";
      package = pkgs.banana-cursor;
      size = 40;
    };

    fonts = {
      sansSerif = {
        package = pkgs.geist-font;
        name = "Geist";
      };

      serif = config.stylix.fonts.sansSerif;

      monospace = {
        package = iosevka;
        name = "Iosevka Custom";
      };

      sizes = {
        applications = 11;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
  };
}
