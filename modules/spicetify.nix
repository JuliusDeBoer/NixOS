{ inputs, pkgs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  programs.spicetify = {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
    ];

    theme = spicePkgs.themes.text;
    colorScheme = "Kanagawa";
  };
}
