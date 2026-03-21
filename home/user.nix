{
  pkgs,
  userSettings,
  systemSettings,
  lib,
  ...
}:
with lib.hm.gvariant;

{

  imports = [
    ./dconf-extension.nix  
  ];
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
        antigravity

        # Windows
        winboat
        freerdp

        # --- Version Control ---
        git
        git-lfs

        # --- Media & Internet ---
        vrcx
        localsend

        # --- Networking & VPN ---
        protonvpn-gui
        cloudflare-warp

        # --- System & Gaming ---
        flatpak
        papirus-icon-theme

        # --- CLI Fun & Utilities ---
        lolcat
        btop
      ]
    else if systemSettings.hostname == "retrex" then
      [
        # VR
        alvr
        sidequest
        libcap

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
          "com.github.rafostar.Clapper"
          "org.localsend.localsend_app"
          "io.gitlab.theevilskeleton.Upscaler"
          "com.github.tchx84.Flatseal"
          "org.mozilla.Thunderbird"
          "com.github.wwmm.easyeffects"
          "org.torproject.torbrowser-launcher"
          "net.blockbench.Blockbench"
          "app.zen_browser.zen"
          "org.gnome.Loupe"
          "org.gnome.World.PikaBackup"
          "io.ente.auth"
          "org.freedesktop.Platform.GL32.nvidia-580-119-02"
          "im.fluffychat.Fluffychat"
          "md.obsidian.Obsidian"
          "org.libreoffice.LibreOffice"
          "dev.vencord.Vesktop"
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
          "org.freedesktop.Platform.GL32.nvidia-580-119-02"
        ]
      else
        [ ];
    update.auto.enable = true;
    uninstallUnmanaged = true;
  };

  dconf.settings = {
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
      ];
      favorite-apps = [
        "app.zen_browser.zen.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
        "dev.vencord.Vesktop.desktop"
        "vesktop.desktop"
        "Mattermost.desktop"
        "im.fluffychat.Fluffychat.desktop"
        "org.mozilla.Thunderbird.desktop"
        "org.gnome.World.PikaBackup.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
    icon-theme = "Papirus";
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
