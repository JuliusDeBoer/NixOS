{ lib, config, ... }:
{
  home-manager.users.julius = {
    stylix.targets.waybar.enable = false;
    programs.waybar = {
      enable = true;
      style = (
        builtins.readFile ./waybar.css
        + ''
          @define-color base00 #${config.lib.stylix.colors.base00};
          @define-color base01 #${config.lib.stylix.colors.base01};
          @define-color base02 #${config.lib.stylix.colors.base02};
          @define-color base03 #${config.lib.stylix.colors.base03};
          @define-color base04 #${config.lib.stylix.colors.base04};
          @define-color base05 #${config.lib.stylix.colors.base05};
          @define-color base06 #${config.lib.stylix.colors.base06};
          @define-color base07 #${config.lib.stylix.colors.base07};
          @define-color base08 #${config.lib.stylix.colors.base08};
          @define-color base09 #${config.lib.stylix.colors.base09};
          @define-color base0A #${config.lib.stylix.colors.base0A};
          @define-color base0B #${config.lib.stylix.colors.base0B};
          @define-color base0C #${config.lib.stylix.colors.base0C};
          @define-color base0D #${config.lib.stylix.colors.base0D};
          @define-color base0E #${config.lib.stylix.colors.base0E};
          @define-color base0F #${config.lib.stylix.colors.base0F};

          * {
            font-family: "${config.stylix.fonts.monospace.name}";
          }
        ''
      );
      settings = {
        main = {
          # Choose the order of the modules
          modules-left = [
            "hyprland/workspaces"
          ];

          modules-center = [ "custom/media" ];

          modules-right = [
            "cpu"
            "memory"
            "network"
            "pulseaudio"
            "battery"
            "tray"
            "clock"
          ];

          "custom/disk_root" = {
            format = "💽 {} ";
            interval = 120;
            exec = "df -h --output=avail / | tail -1 | tr -d ' '";
          };

          temperature = {
            critical-threshold = 80;
            format = "{icon} {temperatureC}°C";
            format-icons = [
              ""
              ""
              ""
            ];
          };

          cpu = {
            format = "CPU: {usage}%";
            tooltip = false;
          };

          memory = {
            format = "{used:0.1f}G/{total:0.1f}G";
          };

          network = {
            format-wifi = "⇵ {bandwidthUpBits}dB";
            format-alt = "{essid}: {ipaddr}/{cidr}";
            format-disconnected = "Disconnected ⚠";
            interval = 5;
          };

          backlight = {
            format = "{icon} {percent}%";
            format-icons = [
              ""
              ""
            ];
          };

          pulseaudio = {
            # "scroll-step" = 1; // %, can be a float
            format = "{icon} {volume}% {format_source}";
            format-muted = "🔇 {format_source}";
            format-bluetooth = "{icon} {volume}% {format_source}";
            format-bluetooth-muted = "🔇 {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphones = "";
              handsfree = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = [
                ""
                ""
                ""
              ];
            };
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          };

          clock = {
            interval = 1;
            format = "{:%H:%M:%S}";
            tooltip-format = "{:%Y-%m-%d | %H:%M:%S}";
          };

          battery = {
            states = {
              warning = 20;
              critical = 10;
            };
            format = "{icon} {capacity}% ({time})";
            format-charging = "  {capacity}%";
            format-plugged = "{icon}  {capacity}% ({time})";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };

          "battery#bat2" = {
            bat = "BAT2";
          };

          tray = {
            spacing = 10;
          };
        };
      };
    };
  };
}
