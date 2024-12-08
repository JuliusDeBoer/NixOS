# Limbo
#
# A place for packages that are semi-permanent.

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    beekeeper-studio
    docker
    dotnetCorePackages.dotnet_8.sdk
    godot_4
    jetbrains.rider
    ldtk
    wl-clipboard
    kicad-small
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
