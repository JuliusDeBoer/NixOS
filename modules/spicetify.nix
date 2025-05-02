{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  stylix.targets.spicetify.enable = false;

  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
    ];

    theme = spicePkgs.themes.text;
    colorScheme = "Kanagawa";
  };
}
