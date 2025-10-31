{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

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
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };

      emoji = {
        package = pkgs.noto-fonts-monochrome-emoji;
        name = "Noto Emoji";
      };

      sizes = {
        applications = 11;
        desktop = 10;
        popups = 10;
        terminal = 16;
      };
    };
  };
}
