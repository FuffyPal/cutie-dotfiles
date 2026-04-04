# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "/org/gnome/shell/extensions/Battery-Health-Charging" = {
      charging-mode = "max";
      device-type = 12;
      icon-style-type = 0;
      indicator-position-max = 2;
      show-battery-panel2 = false;
      show-system-indicator = false;
    };

    "/org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "/org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "/org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "/org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      sigma = 30;
    };

    "/org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "/org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 3;
      user-enabled = true;
    };

    "/org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      custom-theme-shrink = true;
      dash-max-icon-size = 64;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      scroll-action = "switch-workspace";
      show-trash = false;
    };

    "/org/gnome/shell/extensions/forge" = {
      css-last-update = mkUint32 37;
    };

    "/org/gnome/shell/extensions/gsconnect" = {
      devices = [ "1b2f486cc1ac4c2fab7ef66faef0ad26" ];
      missing-openssl = false;
      name = "cutie";
    };

    "/org/gnome/shell/extensions/just-perfection" = {
      background-menu = false;
      controls-manager-spacing-size = 22;
      dash = true;
      double-super-to-appgrid = false;
      osd = true;
      osd-position = 1;
      panel = true;
      panel-size = 24;
      ripple-box = false;
      search = false;
      startup-status = 0;
      support-notifier-type = 0;
      theme = false;
      window-demands-attention-focus = true;
      window-picker-icon = false;
      window-preview-caption = false;
      window-preview-close-button = true;
      workspace = true;
      workspace-background-corner-size = 15;
      workspace-popup = false;
      workspaces-in-app-grid = true;
    };

    "/org/gnome/shell/extensions/libpanel" = {
      layout = [ [ "gnome@main" "quick-settings-audio-panel@rayzeq.github.io/main" ] ];
    };

    "/org/gnome/shell/extensions/quick-settings-audio-panel" = {
      version = 2;
    };

    "/org/gnome/shell/extensions/quick-settings-avatar" = {
      avatar-position = 1;
    };

    "/org/gnome/shell/extensions/tilingshell" = {
      last-version-name-installed = "17.1";
      layouts-json = "[{\"id\":\"Layout 1\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[2,3]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]},{\"x\":0.78,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]}]},{\"id\":\"Layout 2\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[1]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[1,2]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[2]}]},{\"id\":\"Layout 3\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]},{\"x\":0.33,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]}]},{\"id\":\"Layout 4\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]},{\"x\":0.67,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]}]}]";
      overridden-settings = "{\"org.gnome.mutter.keybindings\":{\"toggle-tiled-right\":\"['<Super>Right']\",\"toggle-tiled-left\":\"['<Super>Left']\"},\"org.gnome.desktop.wm.keybindings\":{\"maximize\":\"['<Super>Up']\",\"unmaximize\":\"['<Super>Down', '<Alt>F5']\"},\"org.gnome.mutter\":{\"edge-tiling\":\"true\"}}";
      selected-layouts = [ [ "Layout 1" ] [ "Layout 1" ] [ "Layout 1" ] ];
      window-use-custom-border-color = false;
    };

  };
}
