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
    de.hyprland
    de.xfce
    development
    dns
    fonts
    git
    grub
    i18n
    limbo
    shell
    spicetify
    steam
    stylix
    terminal
    unfree
    wine
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

  boot.tmp.cleanOnBoot = true;

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

  security.sudo-rs.enable = true;

  users.users.julius = {
    isNormalUser = true;
    description = "Julius";
    # Security is my passion
    # "password"
    initialHashedPassword = "$y$j9T$VXaVt7NIKft5fsPh3xQtc.$xpISZFq9m8pe8JErb/BawJOuxStpmRcDymIBNCgwgM0";
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
        openssh
        onefetch

        chromium

        vesktop

        gimp
        inkscape

        libreoffice
      ];

      programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        nix-direnv.enable = true;
      };

      programs.vim = {
        enable = true;
        settings = {
          number = true;
          relativenumber = true;
        };
        extraConfig = "
          set nofixeol
          set nofixendofline
        ";
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
