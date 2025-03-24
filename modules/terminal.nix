{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.global = {
    terminal = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum [ "ghostty" ]);
      description = "The primary terminal emulator";
    };

    # Internal
    generated.terminalExe = lib.mkOption {
      type = lib.types.str;
      description = "The command to the primary terminal emulator executable";
      default = "exit 1";
    };
  };

  config = lib.mkIf (config.global.terminal == "ghostty") {
    environment.systemPackages = with pkgs; [ ghostty ];

    global.generated.terminalExe = "${pkgs.ghostty}/bin/ghostty";

    home-manager.users.julius =
      { ... }:
      {
        xdg.configFile."ghostty/config".text = ''
          font-family = "Iosevka Term"
          theme = "Oxocarbon"
          # NOTE(Julius): For some reason XFCE doesn't add window decorations
          #               by itself.
          # gtk-titlebar = false
        '';
      };
  };
}
