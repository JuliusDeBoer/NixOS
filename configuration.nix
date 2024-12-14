{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./modules/de/gnome.nix
    ./modules/dns.nix
    ./modules/git.nix
    ./modules/grub.nix
    ./modules/i18n.nix
    ./modules/limbo.nix
    ./modules/shell.nix
    ./modules/steam.nix
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "steam-original"
      "spotify"
      "discord"
      "rider"
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  hardware.pulseaudio.enable = false;
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

        zed-editor

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

      programs.vim = {
        enable = true;
        settings = {
          number = true;
          relativenumber = true;
        };
        # Return to monke
        defaultEditor = true;
      };

      programs.wezterm = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = true;
        extraConfig = ''
          local wezterm = require 'wezterm'
          local config = wezterm.config_builder()

          config.color_scheme = 'Tokyo Night'

          config.font = wezterm.font('Iosevka Term')
          config.front_end = "WebGpu"
          config.enable_tab_bar = false
          enable_wayland = true

          return config
        '';
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
      targets = ["wasm32-unknown-unknown"];
    })
    zen.specific
  ];

  system.stateVersion = "23.05";
}
