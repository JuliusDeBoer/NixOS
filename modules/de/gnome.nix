# https://nixos.wiki/wiki/GNOME

{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (
    with pkgs;
    [
      gnome-photos
      gnome-tour
      cheese # webcam tool
      gnome-music
      gnome-terminal
      epiphany # web browser
      gedit # text editor
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
      gnome-maps
    ]
  );

  # Get gnome tray icons working
  environment.systemPackages = with pkgs; [ gnomeExtensions.appindicator ];
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  home-manager.users.julius =
    { pkgs, ... }:
    {
      home.packages = [
        # Doesnt work at the time of writing.
        pkgs.gnomeExtensions.open-bar
      ];

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          cursor-size = 24;
          enable-hot-corners = false;
          font-name = "Geist 10";
          show-battery-percentage = true;
          toolbar-style = "text";
        };
        "org/gnome/shell" = {
          favorite-app = [ ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/open_terminal" = {
          name = "Open terminal";
          binding = "<Super>Return";
          command = "wezterm";
        };
      };
    };
}
