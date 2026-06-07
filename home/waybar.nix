{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 22;
        spacing = 4;
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "tray"
        ];

        "niri/workspaces" = {
          disable-scroll = true;
          format = "{icon}";
          format-icons = {
            focused = "";
            active = "";
            empty = "";
            default = "";
          };
          all-outputs = true;
        };

        "niri/window" = {
          format = "{}";
          max-length = 40;
        };

        "clock" = {
          format = "󱑒  {:%H:%M}";
          format-alt = "  {:%A, %B %d, %Y}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = "  {icon}";
          format-plugged = "  {icon}";
          format-alt = "{icon} {time}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip-format = "{capacity}% - {time} left";
        };

        "network" = {
          format-wifi = "";
          format-ethernet = "󰈀  {ipaddr}/{cidr}";
          format-disconnected = "󰖪  Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
        };

        "pulseaudio" = {
          format = "{icon}";
          format-bluetooth = "{icon} ";
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          tooltip-format = "Volume: {volume}%";
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
      };
    };

    style = ''
      /* Catppuccin Mocha Renk Paleti */
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color text #cdd6f4;
      @define-color mauve #cba6f7;
      @define-color blue #89b4fa;
      @define-color lavender #b4befe;
      @define-color red #f38ba8;
      @define-color surface0 #313244;

      * {
          font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
          font-weight: bold;
      }

      window#waybar {
          background-color: transparent;
          color: @text;
      }

      .modules-left, .modules-center, .modules-right {
          background-color: @base;
          border: 2px solid @surface0;
          border-radius: 10px;
          padding: 2px 10px;
          margin-top: 5px;
      }

      #workspaces button {
          padding: 0 4px;
          color: @lavender;
      }

      #workspaces button.focused {
          color: @mauve;
      }

      #workspaces button.empty {
          color: @surface0;
      }

      #clock {
          color: @lavender;
      }

      #pulseaudio {
          color: @blue;
          margin-right: 15px;
          padding-left: 5px;
          padding-right: 5px;
      }

      #network {
          color: @mauve;
          margin-right: 15px;
      }

      #battery {
          color: @blue;
          padding-left: 5px;
          padding-right: 5px;
      }

      #battery.critical:not(.charging) {
          color: @red;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
    '';
  };
}
