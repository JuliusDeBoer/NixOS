# Limbo
#
# A place for packages that are semi-permanent.

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    btop
    docker
    drawio
    fastfetch
    godot_4
    kicad-small
    ldtk
    rust-analyzer
    wl-clipboard
  ];

  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true;

  home-manager.users.julius =
    { ... }:
    {
      home.file.".config/aseprite/aseprite.ini".text = ''
        [theme]
        selected = dark
      '';
    };
}
