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
            "hyprland/mode"
          ];

          modules-center = [ "custom/media" ];

          modules-right = [
            "custom/disk_root"
            "temperature"
            "cpu"
            "memory"
            "network"
            "backlight"
            "pulseaudio"
            "clock"
            "battery"
            "idle_inhibitor"
            "tray"
          ];

          # Modules configuration
          "hyprland/mode" = {
            format = "{}";
          };

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
            format = "🏭 {usage}%";
            tooltip = false;
          };

          memory = {
            format = "💾 {total:0.1f}G/{used:0.1f}G";
          };

          network = {
            format-wifi = " {essid} {frequency} {signaldBm} dB ⇵ {bandwidthUpBits}/{bandwidthDownBits}";
            format-ethernet = "{ifname}: {ipaddr}/{cidr} ";
            format-linked = "{ifname} {ipaddr}";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
            interval = 5;
          };

          backlight = {
            format = "{icon} {percent}%";
            format-icons = [
              "🔅"
              "🔆"
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
            format = "⏰ {:%H:%M:%S}";
            tooltip-format = "{:%Y-%m-%d | %H:%M:%S}";
            # "format-alt" = "{:%Y-%m-%d}";
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
            # "icon-size" = 21;
            spacing = 10;
          };

          "custom/media" = {
            format = "{icon} {}";
            return-type = "json";
            max-length = 40;
            format-icons = {
              spotify = "";
              default = "🎜";
            };
            escape = true;
            exec = "echo 'No Media'"; # Placeholder if mediaplayer.py doesn't exist
          };

          mpd = {
            format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ";
            format-disconnected = "Disconnected ";
            format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
            unknown-tag = "N/A";
            interval = 2;
            consume-icons = {
              on = " ";
            };
            random-icons = {
              off = " ";
              on = " ";
            };
            repeat-icons = {
              on = " ";
            };
            single-icons = {
              on = "1 ";
            };
            state-icons = {
              paused = "";
              playing = "";
            };
            tooltip-format = "MPD (connected)";
            tooltip-format-disconnected = "MPD (disconnected)";
          };
        };
      };
    };
  };

  # Install required packages for waybar modules
  environment.systemPackages = with pkgs; [
    pulseaudio # for pactl command
    playerctl # for media control
  ];
}
