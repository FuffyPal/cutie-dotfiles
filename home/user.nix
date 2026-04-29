{
  pkgs,
  pkgs-unstable,
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
    if systemSettings.hostname == "cutie" then
      [
        # --- Editors ---
        pkgs.helix
        pkgs-unstable.zed-editor
        pkgs-unstable.lapce

        # --- Windows ---
        #pkgs.winboat
        #pkgs.freerdp

        # --- Version Control ---
        pkgs.git
        pkgs.git-lfs

        # --- Media & Internet ---
        pkgs.vrcx
        pkgs.localsend
        pkgs.librewolf
        pkgs.thunderbird

        # --- Networking & VPN ---
        pkgs.protonvpn-gui
        pkgs.cloudflare-warp

        # --- System & Gaming ---
        pkgs.flatpak
        pkgs.papirus-icon-theme

        # --- CLI Fun & Utilities ---
        pkgs.lolcat
        pkgs.btop

        # --- Nix Devel ENV ---
        pkgs.nixd
        pkgs.nil
      ]
    else if systemSettings.hostname == "retrex" then
      [
        # VR
        pkgs.alvr
        pkgs.sidequest
        pkgs.libcap

        # Editors
        pkgs.helix
        pkgs.gemini-cli
        pkgs.codex
        pkgs.opencode
        pkgs.cursor-cli
        pkgs.code-cursor

        # Version Control
        pkgs.git
        pkgs.git-lfs

        # Media & Internet
        pkgs.google-chrome
        pkgs.ffmpeg
        pkgs.vesktop
        pkgs.vrcx

        # System & Gaming
        pkgs.flatpak
        pkgs.papirus-icon-theme

        # CLI Utilities
        pkgs.bat
        pkgs.lolcat
        pkgs.btop
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
      ls="ls --color=auto";
      l="ls --color=auto";
      ll="ls -lh --color=auto";
      la="ls -lha --color=auto";
      grep="grep --color=auto";
      helix="hx";
      hx="hx";
      cat="lolcat";
      top="btop";
      myip="curl -s ifconfig.me";
      gs="git status";
      ga="git add";
      gc="git commit";
      gp="git push";
      gl="git log --oneline --graph --decorate";
      up = "cd /home/${userSettings.username}/cutie-dotfiles && git pull && sudo nixos-rebuild switch --flake .#cutie";
      comfyui-up = "sudo systemctl start podman-comfyui.service";
      comfyui-down = "sudo systemctl stop podman-comfyui.service";
      comfyui-status = "systemctl status podman-comfyui.service";
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
          "com.github.wwmm.easyeffects"
          "org.torproject.torbrowser-launcher"
          "org.gnome.Loupe"
          "io.ente.auth"
          "org.freedesktop.Platform.GL.nvidia-595-58-03"
          "md.obsidian.Obsidian"
          "dev.deedles.Trayscale"
          "dev.vencord.Vesktop"
          "org.gnome.seahorse.Application"
          "org.cockpit_project.CockpitClient"
          "io.github.giantpinkrobots.varia"
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
        "cloudflare-warp-toggle@khaled.is-a.dev"
      ];
      favorite-apps = [
        "app.zen_browser.zen.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
        "dev.vencord.Vesktop.desktop"
        "vesktop.desktop"
        "md.obsidian.Obsidian.desktop"
        "Mattermost.desktop"
        "element-desktop.desktop"
        "im.fluffychat.Fluffychat.desktop"
        "org.mozilla.Thunderbird.desktop"
        "org.gnome.World.PikaBackup.desktop"
        "btrfs-assistant.desktop"
      ];
    };
    "org/gnome/desktop/interface" = {
    icon-theme = "Papirus";
    };
  };

  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        name = userSettings.name;
        email = userSettings.email;
      };
    };
  };
  programs.home-manager.enable = true;
}
