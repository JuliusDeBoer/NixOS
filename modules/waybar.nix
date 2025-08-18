{ pkgs, ... }:
{
  home-manager.users.julius = {
    programs.waybar = {
      enable = true;
      settings = {
        main = {
          # Choose the order of the modules
          modules-left = [
            "hyprland/workspaces"
          ];

          modules-center = [ "custom/media" ];

          modules-right = [
            "custom/disk_root"
            "cpu"
            "temperature"
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
            # "thermal-zone" = 2;
            # "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
            critical-threshold = 80;
            # "format-critical" = "{temperatureC}°C {icon}";
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
            format-wifi = " {essid} dB ⇵ {bandwidthUpBits}/{bandwidthDownBits}";
            format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
            format-linked = "{ifname} {ipaddr}";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
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
                "🔈"
                "🔉"
                "🔊"
              ];
            };
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          };

          clock = {
            interval = 1;
            format = "{:%H:%M:%S}";
            tooltip-format = "{:%Y-%m-%d | %H:%M:%S}";
            format-alt = "{:%Y-%m-%d} {:%H:%M:%S}";
          };

          battery = {
            states = {
              # "good" = 95;
              warning = 20;
              critical = 10;
            };
            format = "{icon} {capacity}% ({time})";
            format-charging = "  {capacity}%";
            format-plugged = "{icon}  {capacity}% ({time})";
            # "format-good" = ""; // An empty format will hide the module
            # "format-full" = "";
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
