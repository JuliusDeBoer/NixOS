# Limbo
#
# A place for packages that are semi-permanent.

{
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    bacon
    btop
    calibre
    cloc
    docker
    fastfetch
    glow
    jq
    lb
    localsend
    mariadb
    nicotine-plus
    nmap
    thunderbird
    typst
    wl-clipboard
    zathura
  ];

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  virtualisation.docker.enable = true;
  programs.nix-ld.enable = true;
  programs.nh.enable = true;

  # NOTE(julius): Required for calibre
  services.udisks2.enable = true;

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
