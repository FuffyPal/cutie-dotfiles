{
  pkgs,
  pkgs-unstable,
  userSettings,
  systemSettings,
  ...
}:

{

  imports =
    [ ]
    ++ (
      if (systemSettings.desktop == "gnome") then
        [
          ./dconf-extension.nix
        ]
      else
        [ ]
    );
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
        pkgs-unstable.antigravity

        # --- Windows ---
        pkgs-unstable.winboat
        pkgs.freerdp

        # --- Version Control ---
        pkgs.git
        pkgs.git-lfs

        # --- Media & Internet ---
        pkgs.vrcx
        pkgs.vesktop
        pkgs.google-chrome
        pkgs.davinci-resolve
        pkgs.obs-studio
        pkgs.krita

        # --- Networking & VPN ---
        pkgs.protonvpn-gui
        pkgs.cloudflare-warp

        # --- System & Gaming ---
        pkgs.flatpak
        pkgs.papirus-icon-theme
        pkgs-unstable.rustdesk

        # --- CLI Fun & Utilities ---
        pkgs.lolcat
        pkgs.btop
        pkgs.arrpc

        # --- Nix Devel ENV ---
        pkgs.nixd
        pkgs.nil

        # --- Rust Devel ENV ---
        pkgs.cargo
        pkgs.rustc
        pkgs.rust-analyzer
        pkgs.rustfmt
        pkgs.clippy
        pkgs.gcc

        # --- Python Devel ENV ---
        pkgs.python3
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
      ls = "ls --color=auto";
      l = "ls --color=auto";
      ll = "ls -lh --color=auto";
      la = "ls -lha --color=auto";
      grep = "grep --color=auto";
      helix = "hx";
      hx = "hx";
      cat = "lolcat";
      top = "btop";
      myip = "curl -s ifconfig.me";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";
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
          "io.gitlab.theevilskeleton.Upscaler"
          "org.localsend.localsend_app"
          "org.mozilla.thunderbird"
          "io.podman_desktop.PodmanDesktop"
          "io.gitlab.librewolf-community"
          "com.github.tchx84.Flatseal"
          "com.github.wwmm.easyeffects"
          "org.torproject.torbrowser-launcher"
          "org.gnome.Loupe"
          "io.ente.auth"
          "dev.deedles.Trayscale"
          "org.gnome.seahorse.Application"
          "org.cockpit_project.CockpitClient"
          "io.github.giantpinkrobots.varia"
          "org.gnome.Boxes"
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
    update.auto.onCalendar = "16:00";
    uninstallUnmanaged = true;
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
