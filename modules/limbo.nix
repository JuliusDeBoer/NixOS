# Limbo
#
# A place for packages that are semi-permanent.

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    beekeeper-studio
    docker
    godot_4
    kicad-small
    ldtk
    rust-analyzer
    wl-clipboard
  ];

  virtualisation.docker.enable = true;

  home-manager.users.julius =
    { ... }:
    {
      home.file.".config/aseprite/aseprite.ini".text = ''
        [theme]
        selected = dark
      '';
    };
}
