{
  pkgs,
  lib,
  ...
}:
let
  modules = import ./modules/default.nix { inherit lib pkgs; };
in
{
  imports = with modules; [
    de.xfce
    dns
    git
    grub
    i18n
    limbo
    shell
    steam
    unfree
    zed
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

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

        ghostty

        chromium

        spotify
        vesktop

        gimp
        inkscape

        (iosevka.override {
          set = "term";
          privateBuildPlan = {
            family = "Iosevka Term";
            spacing = "term";
            serifs = "sans";
            noCvSs = true;
            exportGlyphNames = false;
            ligations = {
              inherits = "dlig";
            };
            weights.Regular = {
              shape = 400;
              menu = 400;
              css = 400;
            };
            widths.Normal = {
              shape = 500;
              menu = 5;
              css = "normal";
            };
            webfontFormats = "TTF";
          };
        })

        libreoffice
      ];

      xdg.configFile."ghostty/config".text = ''
        font-family = "Iosevka Term"
        gtk-titlebar = false
      '';

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

    # Fonts
    geist-font

    (rust-bin.nightly.latest.default.override {
      targets = [ "wasm32-unknown-unknown" ];
    })

    zen
  ];

  system.stateVersion = "23.05";
}
