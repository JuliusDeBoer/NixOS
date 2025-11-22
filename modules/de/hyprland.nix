{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  programs.hyprland.enable = true;
  # TODO(Julius): Remember why I did this.
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  environment.systemPackages = with pkgs; [
    grimblast
    hyprlock
    hyprpaper
    inputs.noctalia.packages.${system}.default
    playerctl
    rofi
  ];

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  home-manager.users.julius =
    { ... }:
    {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      stylix.targets.hyprlock.enable = false;

      programs.rofi.enable = true;

      programs.noctalia-shell = {
        enable = true;
        colors = with config.lib.stylix.colors; {
          mError = "#${base08}";
          mOnError = "#${base00}";
          mOnPrimary = "#${base00}";
          mOnSecondary = "#${base00}";
          mOnSurface = "#${base04}";
          mOnSurfaceVariant = "#${base04}";
          mOnTertiary = "#${base00}";
          mOutline = "#${base02}";
          mPrimary = "#${base0B}";
          mSecondary = "#${base0A}";
          mShadow = "#${base00}";
          mSurface = "#${base00}";
          mSurfaceVariant = "#${base01}";
          mTertiary = "#${base0D}";
        };
        settings = {
          ui = with config.stylix.fonts; {
            fontDefault = sansSerif.name;
            fontFixed = monospace.name;
          };
          dock.enabled = false;
          bar.widgets = {
            left = [
              {
                id = "SystemMonitor";
              }
              {
                id = "ActiveWindow";
              }
              {
                id = "MediaMini";
                showAlbumArt = true;
                showVisualizer = true;
                maxWidth = 290;
              }
            ];
            center = [
              {
                id = "Workspace";
              }
            ];
            right = [
              {
                id = "Tray";
              }
              {
                id = "NotificationHistory";
              }
              {
                id = "Battery";
                displayMode = "alwaysShow";
              }
              {
                id = "Volume";
              }
              {
                id = "Brightness";
              }
              {
                id = "Clock";
              }
              {
                id = "ControlCenter";
              }
            ];
          };
        };
      };

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;

        settings = {
          "$mod" = "SUPER";

          monitor = [
            ", 1920x1080, 0x0, 1"
          ];

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          exec-once = [
            "noctalia-shell"
            "hyprpaper"
          ];

          bind = [
            (lib.strings.concatStrings [
              "$mod, Return, exec, "
              config.global.generated.terminalExe
            ])
            "ALT, Space, exec, noctalia-shell ipc call launcher toggle"
            "ALT_SHIFT, Space, exec, rofi -show run"
            "$mod, F, fullscreen"
            "$mod, Q, killactive"
            "$mod, Space, togglefloating"

            "$mod, Escape, exec, noctalia-shell ipc call lockScreen lock"

            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"

            "SUPER_SHIFT, H, swapwindow, l"
            "SUPER_SHIFT, J, swapwindow, d"
            "SUPER_SHIFT, K, swapwindow, u"
            "SUPER_SHIFT, L, swapwindow, r"

            ", PRINT, exec, grimblast copy area"
            "SHIFT, PRINT, exec, grimblast save area"
          ]
          # NOTE(Julius): This isnt pretty. But it is the easiest way of doing
          #               it. So I dont really care. (Plus its really cool)
          ++ (builtins.map (x: "$mod, " + toString x + ", workspace, " + toString x) (lib.lists.range 1 9))
          ++ (builtins.map (x: "SUPER_SHIFT, " + toString x + ", movetoworkspace, " + toString x) (
            lib.lists.range 1 9
          ));

          bindel = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
            ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
          ];

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];

          misc = {
            disable_hyprland_logo = true;
          };
        };
      };

      services.hyprpaper = {
        enable = true;
        settings.preload = [ "${../../assets/a_building_with_people_sitting_on_a_bench.jpg}" ];
        settings.wallpaper = [ ", ${../../assets/a_building_with_people_sitting_on_a_bench.jpg}" ];
      };

      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            disable_loading_bar = true;
            grace = 300;
            hide_cursor = true;
            no_fade_in = false;
          };

          background = [
            {
              path = "screenshot";
              blur_passes = 3;
              blur_size = 8;
            }
          ];

          input-field = [
            {
              size = "200, 50";
              position = "0, -80";
              monitor = "";
              dots_center = true;
              fade_on_empty = false;
              font_color = "rgb(202, 211, 245)";
              inner_color = "rgb(91, 96, 120)";
              outer_color = "rgb(24, 25, 38)";
              outline_thickness = 5;
              placeholder_text = "Password...";
              shadow_passes = 2;
            }
          ];

          label = [
            {
              monitor = "";
              text = "cmd[update:1000] echo \"$(date +\"%H:%M:%S\")\"";
              color = "rgba(200, 200, 200, 1.0)";
              font_size = 55;
              font_family = "Geist Mono";
              position = "0, 80";
              halign = "center";
              valign = "center";
            }
          ];
        };
      };
    };
}
