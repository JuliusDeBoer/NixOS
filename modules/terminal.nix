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

    global.generated.terminalExe = "${pkgs.ghostty}/bin/ghostty";

    home-manager.users.julius =
      { ... }:
      {
        programs.ghostty.enable = true;

        # TODO(Julius): Get the font from somewhere else
        xdg.configFile."ghostty/config".text = ''
          font-family = "Maple Mono NF"
          theme = "Kanagawa Dragon"
        '';
      };
  };
}
