{
  pkgs,
  userSettings,
  lib,
  ...
}:
with lib.hm.gvariant;

{

  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";
  home.file.".face".source = ../assets/images/avatar.jpg;

  home.stateVersion = "25.11";

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home.packages = with pkgs; [
    helix
    lolcat
    bat
    git-lfs
    git
    flatpak
    zed-editor
    airshipper
    nixd
    nil
    nixpkgs-fmt
    steam
    mullvad-browser
    localsend
    yt-dlp
    antigravity
    alcom
    ffmpeg
    discord
    papirus-icon-theme
    
    # Go Development (Antigravity for LSP and tools)
    go
    gopls
    delve
    golangci-lint
    gotools
  ];
  
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 1000;
    historyControl = [
      "ignoredups"
      "erasedups"
    ];
    shellAliases = {
      ll = "ls -lh";
      la = "ls -lha";
      cat = "lolcat";
      helix = "hx";
    };

    bashrcExtra = ''
      # Sadece Nix'in otomatik yapamadığı "Görsel" ve "Dış Kaynaklı" ayarlar:

      # Renkli Prompt (Kişisel zevk)
      PS1="\[\e[38;2;255;171;185m\]\u@\h \[\e[38;2;180;200;255m\]\w\[\e[0m\]\$ "

      # Eğer bu dosya GitLab'da yoksa hata almamak için kontrol ekledik
      [ -f "$HOME/.alias" ] && source "$HOME/.alias"
    '';
  };

  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.github.rafostar.Clapper"
      "com.github.tchx84.Flatseal"
      "io.gitlab.librewolf-community"
      "org.mozilla.Thunderbird"
      "im.fluffychat.Fluffychat"
      "de.haeckerfelix.Fragments"
      "org.vinegarhq.Sober"
      "com.spotify.Client"
      "io.ente.auth"
      "com.github.wwmm.easyeffects"
      "net.cozic.joplin_desktop"
      "org.gnome.World.PikaBackup"
      "org.prismlauncher.PrismLauncher"
      "dev.deedles.Trayscale"
      "com.unity.UnityHub"
    ];
    update.auto.enable = true;
    uninstallUnmanaged = true; # Nix listesinde olmayanları siler (isteğe bağlı)
  };

  dconf.settings = {
    "Battery-Health-Charging" = {
      charging-mode = "max";
      device-type = 12;
      icon-style-type = 0;
      indicator-position-max = 5;
      polkit-status = "installed";
      show-battery-panel2 = false;
      show-notifications = true;
      show-preferences = true;
      show-quickmenu-subtitle = true;
      show-system-indicator = false;
    };

    "Bluetooth-Battery-Meter" = {
      device-list = [
        ''
          {"path":"/org/bluez/hci0/dev_90_DA_07_6C_92_8C","icon":"audio-headset","alias":"Philips TAH5209","paired":true,"battery-reported":true,"qs-level":true,"indicator-mode":2,"enhanced-device":null,"connected-time":1769782832,"disconnected-time":1769782832}
        ''
      ];
    };

    "blur-my-shell" = {
      settings-version = 2;
    };

    "blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "blur-my-shell/panel" = {
      brightness = 0.6;
      sigma = 30;
    };

    "blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    "caffeine" = {
      duration-timer-list = [
        900
        2700
        5100
      ];
      indicator-position-max = 5;
      use-custom-duration = true;
    };

    "com/github/hermes83/compiz-windows-effect" = {
      last-version = 29;
      preset = "R";
    };

    "org/gnome/desktop/interface" = {
      icon-theme = "Papirus-Dark";
    };

    "dash-to-dock" = {
      background-opacity = 0.8;
      custom-theme-shrink = true;
      dash-max-icon-size = 64;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      isolate-locations = true;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      scroll-action = "switch-workspace";
      show-trash = false;
    };

    "just-perfection" = {
      background-menu = false;
      controls-manager-spacing-size = 22;
      dash = true;
      double-super-to-appgrid = false;
      osd = true;
      osd-position = 1;
      panel = true;
      panel-size = 22;
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

    "tilingshell" = {
      last-version-name-installed = "17.1";
      layouts-json = "[{\"id\":\"Layout 1\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[2,3]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]},{\"x\":0.78,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]}]},{\"id\":\"Layout 2\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[1]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[1,2]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[2]}]},{\"id\":\"Layout 3\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]},{\"x\":0.33,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]}]},{\"id\":\"Layout 4\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]},{\"x\":0.67,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]}]},{\"id\":\"52558\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":1,\"height\":1,\"groups\":[]}]}]";
      overridden-settings = "{\"org.gnome.mutter.keybindings\":{\"toggle-tiled-right\":\"['<Super>Right']\",\"toggle-tiled-left\":\"['<Super>Left']\"},\"org.gnome.desktop.wm.keybindings\":{\"maximize\":\"['<Super>Up']\",\"unmaximize\":\"['<Super>Down', '<Alt>F5']\"},\"org.gnome.mutter\":{\"edge-tiling\":\"true\"}}";
      selected-layouts = [
        [ "Layout 1" ]
        [ "Layout 1" ]
        [ "Layout 1" ]
        [ "Layout 1" ]
        [ "Layout 1" ]
        [ "Layout 1" ]
      ];
      show-indicator = false;
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
        "quick-settings-tweaker@qwreey"
        "mediacontrols@cliffniff.github.com"
        "wiggle@meghatsh.github.com"
      ];
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = userSettings.name;
        email = userSettings.email;
      };
    };
  };
  programs.home-manager.enable = true;
}
