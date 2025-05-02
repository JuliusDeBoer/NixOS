# Limbo
#
# A place for packages that are semi-permanent.

{ pkgs, config, boot, security, ... }:
{
  environment.systemPackages = with pkgs; [
    blender
    btop
    docker
    drawio
    fastfetch
    godot_4
    kicad-small
    ldtk
    pgadmin4-desktopmode
    polybar
    rust-analyzer
    wl-clipboard

    obs-studio
  ];

  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true;
  programs.nh.enable = true;

  home-manager.users.julius =
    { ... }:
    {
      home.file.".config/aseprite/aseprite.ini".text = ''
        [theme]
        selected = dark
      '';
    };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;
}
