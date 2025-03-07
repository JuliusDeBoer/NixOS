{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    (iosevka.override {
      set = "term";
      privateBuildPlan = {
        family = "Iosevka Term";
        spacing = "term";
        serifs = "sans";
        noCvSs = true;
        exportGlyphNames = false;
        ligations = {
          inherits = "dlig";
        };
        weights.Regular = {
          shape = 400;
          menu = 400;
          css = 400;
        };
        widths.Normal = {
          shape = 500;
          menu = 5;
          css = "normal";
        };
        webfontFormats = "TTF";
      };
    })
    geist-font
  ];

}
