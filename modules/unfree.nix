# The global list with all allowed unfree packages
{ lib, ... }:
{
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "discord"
      "spotify"
      "steam"
      "steam-original"
      "steam-unwrapped"
    ];
}
