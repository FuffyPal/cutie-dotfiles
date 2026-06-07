{ ... }: {
  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-width = 380;
      notification-window-width = 350;
      notification-icon-size = 48;
      notification-body-image-height = 100;
      notification-body-image-width = 100;
      timeout = 5;
      timeout-low = 2;
      timeout-critical = 0;
      fit-to-screen = true;
    };

    style = ''
      /* Catppuccin Mocha Renkleri */
      @define-color base #1e1e2e;
      @define-color mantle #181825;
      @define-color text #cdd6f4;
      @define-color mauve #cba6f7;
      @define-color blue #89b4fa;
      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color red #f38ba8;

      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-weight: bold;
      }

      .notification {
        background: @base;
        color: @text;
        border: 2px solid @surface0;
        border-radius: 12px;
        padding: 10px;
        margin: 5px;
        shadow: none;
      }

      .notification-content {
        margin: 5px;
      }

      .notification-default-image {
        color: @blue;
      }

      .notification-critical {
        border: 2px solid @red;
      }

      .control-center {
        background: @base;
        color: @text;
        border: 2px solid @surface0;
        border-radius: 16px;
        padding: 15px;
      }

      .widget-title {
        color: @mauve;
        font-size: 16px;
        margin: 5px;
      }

      .widget-dnd {
        color: @blue;
      }

      .widget-dnd > switch {
        background: @surface0;
        border-radius: 10px;
        border: 1px solid @surface1;
      }

      .widget-dnd > switch:checked {
        background: @mauve;
      }
    '';
  };
}
