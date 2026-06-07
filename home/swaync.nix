{ ... }: {
  services.swaync = {
    enable = true;
    settings = {
      positionX = "center";
      positionY = "top";
      cssPriority = "user";

      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;

      control-center-width = 390;
      control-center-height = 800;
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 0;

      notification-window-width = 380;
      notification-icon-size = 50;
      notification-body-image-height = 200;
      notification-body-image-width = 200;

      timeout = 8;
      timeout-low = 6;
      timeout-critical = 0;

      fit-to-screen = false;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      text-empty = "No Notifications";
      script-fail-notify = true;

      notification-visibility = {
        example-name = {
          state = "muted";
          urgency = "Low";
          app-name = "Spotify";
        };
      };

      widgets = [
        "buttons-grid"
        "mpris"
        "volume"
        "backlight"
        "dnd"
        "title"
        "notifications"
      ];

      widget-config = {
        mpris = {
          image-size = 50;
          image-radius = 12;
        };
        volume = {
          label = " 󰕾 ";
          expand-button-label = " ";
          collapse-button-label = " ";
          show-per-app = true;
          show-per-app-icon = true;
          show-per-app-label = false;
        };
        backlight = {
          label = "󰃟 ";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        title = {
          text = "Notification Center";
          clear-all-button = true;
          button-text = " 󰆴 ";
        };
        buttons-grid = {
          actions = [
            {
              label = " ";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && nmcli radio wifi on || nmcli radio wifi off'";
              update-command = "sh -c '[[ $(nmcli r wifi) == \"enabled\" ]] && echo true || echo false'";
            }
            {
              label = "󰂯";
              type = "toggle";
              active = true;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && rfkill unblock bluetooth || rfkill block bluetooth'";
              update-command = "sh -c \"rfkill list bluetooth | grep -q \\\"Soft blocked: no\\\" && echo true || echo false\"";
            }
            {
              label = " ";
              type = "toggle";
              active = false;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pactl set-source-mute @DEFAULT_SOURCE@ 1 || pactl set-source-mute @DEFAULT_SOURCE@ 0'";
              update-command = "sh -c '[[ $(pactl get-source-mute @DEFAULT_SOURCE@) == *yes* ]] && echo true || echo false'";
            }
            {
              label = " ";
              type = "toggle";
              active = false;
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && pactl set-sink-mute @DEFAULT_SINK@ 1 || pactl set-sink-mute @DEFAULT_SINK@ 0'";
              update-command = "sh -c '[[ $(pactl get-sink-mute @DEFAULT_SINK@) == *yes* ]] && echo true || echo false'";
            }
          ];
        };
      };
    };

    style = ''
      /* Catppuccin Mocha Yarı Şeffaf Renk Tanımlamaları */
      @define-color cc_bg         rgba(30, 30, 46, 0.65);  /* %65 Opak Base - Arka planı gösterecek */
      @define-color cc_bg_alt     rgba(49, 50, 68, 0.55);  /* %55 Opak Surface0 */
      @define-color cc_fg         #cdd6f4;                 /* Catppuccin Text */
      @define-color cc_fg_muted   #a6adc8;                 /* Catppuccin Subtext1 */
      @define-color cc_border     rgba(203, 166, 247, 0.4);/* %40 Opak Mauve Çerçeve */
      @define-color cc_accent     #cba6f7;                 /* Catppuccin Mauve */
      @define-color cc_accent_fg  #11111b;                 /* Catppuccin Crust */
      @define-color cc_danger     rgba(243, 139, 168, 0.65);/* Catppuccin Red */
      @define-color cc_danger_fg  #11111b;
      @define-color surface_highest rgba(69, 71, 90, 0.6);

      * {
          font-family: "JetBrainsMono Nerd Font", "Poppins Semibold", "Symbols Nerd Font";
          font-size: 14px;
          outline: none;
          border: none;
          text-shadow: none;
          color: @cc_fg;
      }

      .control-center {
          background-color: @cc_bg;
          border-radius: 24px;
          border: 2px solid @cc_border;
          padding: 12px;
          backdrop-filter: blur(12px); /* Bazı GTK katmanları için ek güvence */
      }

      .control-center .notification-row .notification-background {
          background-color: transparent;
          border-radius: 12px;
          margin-top: 6px;
      }

      .notification {
          background-color: @cc_bg_alt;
          color: @cc_fg;
          border-radius: 16px;
          border: 1px solid rgba(137, 180, 250, 0.3); /* Hafif Mavi Çerçeve */
          margin: 10px;
          padding: 6px;
      }

      .notification > *:last-child > * {
          margin: 6px;
      }

      .notification-group {
          background-color: @cc_bg;
          border-radius: 16px;
          border: 1px solid @cc_border;
          padding: 4px 4px 0 4px;
          margin-top: 6px;
      }

      .summary,
      .body,
      .widget-title > label,
      .widget-dnd > label,
      .widget-backlight > label,
      .widget-volume label,
      .widget-mpris .widget-mpris-title {
          color: @cc_fg;
      }

      .time,
      .widget-mpris .widget-mpris-subtitle,
      .notification-group-header,
      .notification-group-icon {
          color: @cc_fg_muted;
      }

      .summary { font-size: 1.05rem; padding-left: 12px; font-weight: bold; }
      .time    { font-size: 0.8rem; padding-right: 12px; }
      .body    { font-size: 0.95rem; padding-left: 12px; }

      .notification-content {
          padding: 12px 12px 10px 14px;
      }

      .notification-action > button {
          background-color: @surface_highest;
          border-radius: 8px;
          padding: 6px;
          margin: 6px;
          color: @cc_fg;
      }

      .notification-action > label {
          font-size: 0.95rem;
          color: @cc_fg;
      }

      .notification.critical {
          background-color: @cc_danger;
          border: 2px solid #f38ba8;
          color: @cc_danger_fg;
      }

      .notification.low,
      .notification.normal {
          background-color: @cc_bg_alt;
          border: 1px solid @cc_border;
      }

      .close-button {
          background-color: @surface_highest;
          color: @cc_fg;
          padding: 4px;
          margin: 10px;
          border-radius: 999px;
      }

      .close-button:hover {
          background-color: #f38ba8;
          color: #11111b;
      }

      .notification-group-header,
      .notification-group-icon {
          font-size: 0.9rem;
      }

      .notification-group-collapse-button,
      .notification-group-close-all-button {
          background-color: @surface_highest;
          color: @cc_fg;
          border-radius: 999px;
      }

      .notification-group-close-all-button:hover {
          background-color: #f38ba8;
          color: #11111b;
      }

      scale trough {
          background-color: rgba(203, 166, 247, 0.2);
          border-radius: 999px;
          min-height: 8px;
          min-width: 100px;
          margin: 0 12px;
      }

      scale trough highlight {
          background-color: @cc_accent;
          border-radius: 999px;
      }

      scale trough slider {
          background-color: #89b4fa; /* Mavi slider */
          border-radius: 999px;
          min-width: 14px;
          min-height: 14px;
          margin: -3px 0;
          box-shadow: none;
      }

      scrollbar slider {
          background-color: rgba(166, 173, 200, 0.4);
          border-radius: 999px;
      }

      .widget-buttons-grid {
          font-size: 1.1rem;
          padding: 10px 14px;
      }

      .widget-buttons-grid > flowbox > flowboxchild > button {
          background: @surface_highest;
          color: @cc_fg;
          border-radius: 14px;
          min-width: 65px;
          min-height: 40px;
          padding: 6px;
          margin: 4px;
          transition: all 0.2s ease;
          border: 1px solid rgba(255, 255, 255, 0.05);
      }

      .widget-buttons-grid > flowbox > flowboxchild > button.toggle:checked {
          background: #89b4fa;
          color: #11111b;
      }

      .widget-mpris .widget-mpris-player {
          background-color: rgba(49, 50, 68, 0.4);
          border-radius: 16px;
          border: 1px solid @cc_border;
          padding: 12px;
          margin: 8px 12px;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-album-art {
          border-radius: 10px;
      }

      .widget-mpris .widget-mpris-player .widget-mpris-title {
          font-weight: bold;
          font-size: 1.1rem;
          color: #cba6f7;
      }

      .widget-title {
          padding: 10px 16px;
      }

      .widget-title > label {
          font-size: 1.3rem;
          font-weight: bold;
      }

      .widget-title > button {
          padding: 4px 16px;
          background: #f38ba8;
          color: #11111b;
          border-radius: 999px;
      }
    '';
  };
}
