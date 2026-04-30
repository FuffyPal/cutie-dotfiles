# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/shell/extensions/Battery-Health-Charging" = {
      charging-mode = "max";
      device-type = 12;
      icon-style-type = 0;
      indicator-position-max = 2;
      show-battery-panel2 = false;
      show-system-indicator = false;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = 3;
      user-enabled = true;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
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

    "org/gnome/shell/extensions/forge" = {
      css-last-update = mkUint32 37;
    };

    "org/gnome/shell/extensions/gsconnect" = {
      devices = [ "1b2f486cc1ac4c2fab7ef66faef0ad26" ];
      missing-openssl = false;
      name = "cutie";
    };

    "org/gnome/shell/extensions/just-perfection" = {
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

    "org/gnome/shell/extensions/libpanel" = {
      layout = [
        [
          "gnome@main"
          "quick-settings-audio-panel@rayzeq.github.io/main"
        ]
      ];
    };

    "org/gnome/shell/extensions/quick-settings-audio-panel" = {
      version = 2;
    };

    "org/gnome/shell/extensions/quick-settings-avatar" = {
      avatar-position = 1;
    };

    "org/gnome/shell/extensions/tilingshell" = {
      last-version-name-installed = "17.1";
      layouts-json = "[{\"id\":\"Layout 1\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[2,3]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]},{\"x\":0.78,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]}]},{\"id\":\"Layout 2\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[1]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[1,2]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[2]}]},{\"id\":\"Layout 3\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]},{\"x\":0.33,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]}]},{\"id\":\"Layout 4\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]},{\"x\":0.67,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]}]}]";
      overridden-settings = "{\"org.gnome.mutter.keybindings\":{\"toggle-tiled-right\":\"['<Super>Right']\",\"toggle-tiled-left\":\"['<Super>Left']\"},\"org.gnome.desktop.wm.keybindings\":{\"maximize\":\"['<Super>Up']\",\"unmaximize\":\"['<Super>Down', '<Alt>F5']\"},\"org.gnome.mutter\":{\"edge-tiling\":\"true\"}}";
      selected-layouts = [
        [ "Layout 1" ]
        [ "Layout 1" ]
        [ "Layout 1" ]
      ];
      window-use-custom-border-color = false;
    };
    "org/gnome/desktop/interface" = {
      accent-color = "pink";
    };
    "org/gnome/desktop/background" = {
      picture-uri = "file://${../assets/images/wallpaper.png}";
      picture-uri-dark = "file://${../assets/images/wallpaper.png}";
      picture-options = "zoom";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "file://${../assets/images/wallpaper.png}";
      picture-options = "zoom";
    };
    "org/gnome/desktop/app-folders" = {
      folder-children = [
        "Utilities"
        "Settings"
        "Accessories"
        "Core"
        "YaST"
        "Pardus"
        "Office"
        "Game"
        "Network"
        "AudioVideo"
        "Development"
      ];
    };
    "org/gnome/desktop/app-folders/folders/Utilities" = {
      name = "Zubehör";
      categories = [
        "Utility"
        "Accessories"
        "Core"
        "Settings"
      ];
    };
    "org/gnome/desktop/app-folders/folders/Game" = {
      name = "Spiel";
      categories = [ "Game" ];
    };
    "org/gnome/desktop/app-folders/folders/AudioVideo" = {
      name = "Multimedia";
      categories = [
        "AudioVideo"
        "Audio"
        "Video"
      ];
    };
    "org/gnome/desktop/app-folders/folders/Development" = {
      name = "Entwicklung";
      categories = [ "Development" ];
    };
    "org/gnome/desktop/app-folders/folders/Office" = {
      name = "Büro";
      categories = [ "Office" ];
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "battery-health-charging@maniacx.github.com"
        "Battery-Health-Charging@maniacx.github.com"
        "bluetooth-battery-meter@maniacx.github.com"
        "Bluetooth-Battery-Meter@maniacx.github.com"
        "blur-my-shell@aunetx"
        "caffeine@patapon.info"
        "clipboard-indicator@tudmotu.com"
        "color-picker@tuberry"
        "compiz-windows-effect@hermes82.github.com"
        "compiz-windows-effect@hermes83.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "tilingshell@ferrarodomenico.com"
        "gsconnect@andyholmes.github.io"
        "just-perfection-desktop@just-perfection"
        "weatheroclock@clemens.lab21.org"
        "weatheroclock@CleoMenezesJr.github.io"
        "quick-settings-audio-panel@rayzeq.github.io"
        "quick-settings-tweaker@qwreey"
        "mediacontrols@cliffniff.github.com"
        "wiggle@meghatsh.github.com"
        "forge@jmmaranan.com"
        "qs-touchpad-toggle@crystal"
        "restartto@tiagoporsch.github.io"
        "quick-settings-avatar@d-go"
        "cloudflare-warp-toggle@khaled.is-a.dev"
      ];
      favorite-apps = [
        "app.zen_browser.zen.desktop"
        "librewolf.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
        "dev.vencord.Vesktop.desktop"
        "vesktop.desktop"
        "md.obsidian.Obsidian.desktop"
        "Mattermost.desktop"
        "element-desktop.desktop"
        "im.fluffychat.Fluffychat.desktop"
        "org.mozilla.Thunderbird.desktop"
        "thunderbird.desktop"
        "org.gnome.World.PikaBackup.desktop"
        "btrfs-assistant.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
      icon-theme = "Papirus";
    };
  };
}
