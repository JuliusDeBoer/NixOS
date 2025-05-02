{ pkgs, ... }:
pkgs.iosevka.override {
  set = "term";
  privateBuildPlan = {
    family = "Iosevka Custom";
    spacing = "term";
    serifs = "sans";
    noCvSs = true;
    exportGlyphNames = false;
    variants = {
      inherits = "ss14";
    };
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
}
