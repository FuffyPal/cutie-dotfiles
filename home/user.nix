{
  pkgs,
  userSettings,
  systemSettings,
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
  home.packages =
    with pkgs;
    if systemSettings.hostname == "cutie" then
      [
        # --- Editors ---
        helix
        gemini-cli
        codex
        opencode
        cursor-cli
        code-cursor

        # --- Nix Development & LSPs ---
        nixd # Nix LSP
        nil # Nix LSP (Alternative)
        nixpkgs-fmt # Formatter
        statix # Linter

        # Windows
        winboat
        freerdp

        # --- Go Development ---
        go
        gopls # Go LSP
        delve # Debugger
        golangci-lint # Linter
        gotools

        # --- Rust Development ---
        rustc
        cargo
        rust-analyzer
        pkg-config

        # --- Version Control ---
        git
        git-lfs

        # --- Media & Internet ---
        google-chrome
        ffmpeg
        vesktop
        mattermost-desktop
        nextcloud-client
        vrcx
        arrpc
        yt-dlp
        localsend

        # --- System & Gaming ---
        steam
        airshipper
        flatpak
        papirus-icon-theme

        # --- CLI Fun & Utilities ---
        bat
        lolcat
        btop
        libwebp
        libjxl
        imagemagick
        fdupes
        exiftool
      ]
    else if systemSettings.hostname == "retrex" then
      [
        # VR
        alvr
        sidequest

        # Editors
        helix
        gemini-cli
        codex
        opencode
        cursor-cli
        code-cursor

        # Version Control
        git
        git-lfs

        # Media & Internet
        google-chrome
        ffmpeg
        vesktop
        vrcx

        # System & Gaming
        steam
        flatpak
        papirus-icon-theme

        # CLI Utilities
        bat
        lolcat
        btop
      ]
    else
      [ ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 10000;
    historyControl = [
      "ignoredups"
      "erasedups"
    ];
    shellAliases = {
      ll = "ls -lh";
      la = "ls -lha";
      cat = "lolcat";
      helix = "hx";
      top = "btop";
    };

    bashrcExtra = ''
      PS1="\[\e[38;2;255;171;185m\]\u@\h \[\e[38;2;180;200;255m\]\w\[\e[0m\]\$ "

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
    packages =
      if systemSettings.hostname == "cutie" then
        [
          "com.usebottles.bottles"
          "de.haeckerfelix.Fragments"
          "org.vinegarhq.Sober"
          "org.vinegarhq.Vinegar"
          "io.gitlab.librewolf-community"
          "com.github.rafostar.Clapper"
          "org.localsend.localsend_app"
          "io.gitlab.theevilskeleton.Upscaler"
          "com.github.tchx84.Flatseal"
          "org.prismlauncher.PrismLauncher"
          "org.mozilla.Thunderbird"
          "com.github.wwmm.easyeffects"
          "io.podman_desktop.PodmanDesktop"
          "net.veloren.airshipper"
          "com.github.neithern.g4music"
          "org.torproject.torbrowser-launcher"
          "org.onlyoffice.desktopeditors"
          "re.sonny.Workbench"
          "net.ankiweb.Anki"
          "ar.xjuan.Cambalache"
          "net.blockbench.Blockbench"
          "app.zen_browser.zen"
          "org.remmina.Remmina"
          "com.vysp3r.ProtonPlus"
          "org.onionshare.OnionShare"
          "org.gnome.Loupe"
          "org.gnome.World.PikaBackup"
          "dev.deedles.Trayscale"
          "io.ente.auth"
        ]
      else if systemSettings.hostname == "retrex" then
        [
          "com.usebottles.bottles"
          "org.vinegarhq.Sober"
          "org.vinegarhq.Vinegar"
          "com.github.rafostar.Clapper"
          "com.github.tchx84.Flatseal"
          "com.github.wwmm.easyeffects"
          "org.onlyoffice.desktopeditors"
          "net.blockbench.Blockbench"
          "com.vysp3r.ProtonPlus"
          "app.zen_browser.zen"
          "org.gnome.Loupe"
          "dev.deedles.Trayscale"
        ]
      else
        [ ];
    update.auto.enable = true;
    uninstallUnmanaged = true;
  };

  dconf.settings = {
    "Battery-Health-Charging" = {
      charging-mode = "max";
      device-type = 12;
      icon-style-type = 0;
      indicator-position-max = 3;
      polkit-status = "installed";
      show-battery-panel2 = false;
      show-system-indicator = false;
    };

    "Bluetooth-Battery-Meter" = {
      device-list = [ ''
        {"path":"/org/bluez/hci0/dev_90_DA_07_6C_92_8C","icon":"audio-headset","alias":"Philips TAH5209","paired":true,"battery-reported":true,"qs-level":true,"indicator-mode":2,"enhanced-device":null,"connected-time":1773482945,"disconnected-time":1773482972}
      '' ];
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
      countdown-timer = 2700;
      duration-timer-list = [ 900 2700 5100 ];
      indicator-position-max = 5;
      use-custom-duration = true;
      user-enabled = false;
    };

    "dash-to-dock" = {
      background-opacity = 0.8;
      custom-theme-shrink = true;
      dash-max-icon-size = 64;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      scroll-action = "switch-workspace";
      scroll-to-focused-application = true;
      show-trash = false;
    };

    "gsconnect" = {
      missing-openssl = false;
      name = "cutie";
    };

    "just-perfection" = {
      animation = 1;
      background-menu = false;
      controls-manager-spacing-size = 22;
      dash = true;
      double-super-to-appgrid = false;
      osd = true;
      panel = true;
      panel-size = 23;
      ripple-box = false;
      search = false;
      startup-status = 0;
      support-notifier-type = 0;
      theme = false;
      window-demands-attention-focus = true;
      window-picker-icon = false;
      window-preview-caption = false;
      window-preview-close-button = true;
      workspace = false;
      workspace-background-corner-size = 15;
      workspace-popup = false;
      workspaces-in-app-grid = true;
    };

    "libpanel" = {
      layout = [ [ "quick-settings-audio-panel@rayzeq.github.io/main" ] [ "gnome@main" ] ];
    };

    "tilingshell" = {
      last-version-name-installed = "17.1";
      layouts-json = "[{\"id\":\"Layout 1\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[1,2]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[2,3]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]},{\"x\":0.78,\"y\":0.5,\"width\":0.22,\"height\":0.5,\"groups\":[3,4]}]},{\"id\":\"Layout 2\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[1]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[1,2]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[2]}]},{\"id\":\"Layout 3\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]},{\"x\":0.33,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]}]},{\"id\":\"Layout 4\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]},{\"x\":0.67,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]}]},{\"id\":\"71915\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":1,\"height\":1,\"groups\":[]}]}]";
      overridden-settings = "{\"org.gnome.mutter.keybindings\":{\"toggle-tiled-right\":\"['<Super>Right']\",\"toggle-tiled-left\":\"['<Super>Left']\"},\"org.gnome.desktop.wm.keybindings\":{\"maximize\":\"['<Super>Up']\",\"unmaximize\":\"['<Super>Down', '<Alt>F5']\"},\"org.gnome.mutter\":{\"edge-tiling\":\"true\"}}";
      selected-layouts = [ [ "Layout 1" ] [ "Layout 1" ] [ "Layout 1" ] [ "Layout 1" ] ];
      show-indicator = false;
      snap-assistant-threshold = 55;
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
