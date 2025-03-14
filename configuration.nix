{
  pkgs,
  lib,
  ...
}:
let
  modules = import ./modules/default.nix { inherit lib; };
in
{
  imports = with modules; [
    de.xfce
    dns
    fonts
    git
    grub
    i18n
    limbo
    shell
    steam
    terminal
    unfree
    zed
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };

    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  global.terminal = "ghostty";

  services.pulseaudio.enable = false;

  # TODO(Julius): Move bluetooth stuff to a seperate file
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.julius = {
    isNormalUser = true;
    description = "Julius";
    # NOTE(Julius): Set explicit user id for FS permissions.
    uid = 1000;
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "home-manager.backup";

  home-manager.users.julius =
    { pkgs, ... }:
    {
      home.stateVersion = "24.05";

      home.packages = with pkgs; [
        clang
        nodejs

        pnpm
        openssh
        httpie
        onefetch

        chromium

        spotify
        vesktop

        gimp
        inkscape

        libreoffice
      ];

      programs.vim = {
        enable = true;
        settings = {
          number = true;
          relativenumber = true;
        };
        # Return to monke
        defaultEditor = true;
      };
    };

  environment.systemPackages = with pkgs; [
    wget
    git
    openssh
    bat

    (rust-bin.nightly.latest.default.override {
      targets = [ "wasm32-unknown-unknown" ];
    })

    zen
  ];

  system.stateVersion = "23.05";
}
