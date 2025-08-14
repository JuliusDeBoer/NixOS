{
  pkgs,
  lib,
  config,
  ...
}:
{
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    eww
    grimblast
    playerctl
  ];

  home-manager.users.julius =
    { pkgs, ... }:
    {
      programs.eww = {
        enable = true;
        configDir = ../eww;
      };

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;

        settings = {
          "$mod" = "SUPER";

          monitor = [
            "eDP-1, 1920x1080, 0x0, 1"
          ];

          exec-once = "eww daemon && eww open bar";

          bind =
            [
              (lib.strings.concatStrings [
                "$mod, Return, exec, "
                config.global.generated.terminalExe
              ])
              "ALT, Space, exec, bemenu-run"
              "$mod, F, fullscreen"
              "$mod, Q, killactive"
              "$mod, Space, togglefloating"

              "$mod, H, movefocus, l"
              "$mod, J, movefocus, d"
              "$mod, K, movefocus, k"
              "$mod, L, movefocus, l"

              "SUPER_SHIFT, H, swapwindow, l"
              "SUPER_SHIFT, J, swapwindow, d"
              "SUPER_SHIFT, K, swapwindow, k"
              "SUPER_SHIFT, L, swapwindow, l"

              ", PRINT, exec, grimblast copy area"
              "SHIFT, PRINT, exec, grimblast save area"
            ]
            # NOTE(Julius): This isnt pretty. But it is the easiest way of doing
            #               it. So I dont really care.
            ++ (builtins.map (x: "$mod, " + toString x + ", workspace, " + toString x) (lib.lists.range 1 9))
            ++ (builtins.map (x: "SUPER_SHIFT, " + toString x + ", movetoworkspace, " + toString x) (
              lib.lists.range 1 9
            ));
        };
      };
    };
}
