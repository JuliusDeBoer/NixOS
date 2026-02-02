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
    android-file-transfer
    jetbrains.pycharm
    bacon
    micropython
    python313
    btop
    calibre
    cloc
    docker
    fastfetch
    feh
    glow
    jq
    jujutsu
    lb
    localsend
    mariadb
    metabase
    nicotine-plus
    nmap
    onlyoffice-desktopeditors
    rsync
    thunderbird
    typst
    wireshark
    wl-clipboard
    zathura
  ];

  networking.firewall = {
    enable = true;
    # NOTE(Julius): Allow for LocalSend
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };


  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "julius" ];
  # HACK(Julius)
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

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

      programs.jujutsu = {
        enable = true;
        settings = {
          user = {
            name = "Julius de Boer";
            email = "me@juliusdeboer.com";
          };
        };
      };
    };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;
}
