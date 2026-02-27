{
  systemSettings,
  userSettings,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware.nix
    ./gnome.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
    ../../modules/system/services.nix
    ../../modules/system/fonts.nix
    ./podman.nix
    ./virt-manager.nix
  ]
  ++ (if (systemSettings.gpuType == "hybrid") then [ ./nvidia.nix ] else [ ]);

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowUnfree = true;

  system.activationScripts.userAvatar = {
    text = ''
      mkdir -p /var/lib/AccountsService/icons
      mkdir -p /var/lib/AccountsService/users

      cp ${../../assets/images/avatar.jpg} /var/lib/AccountsService/icons/${userSettings.username}

      echo -e "[User]\nIcon=/var/lib/AccountsService/icons/${userSettings.username}\nSystemAccount=false" > /var/lib/AccountsService/users/${userSettings.username}

      chown root:root /var/lib/AccountsService/icons/${userSettings.username}
      chmod 644 /var/lib/AccountsService/icons/${userSettings.username}
    '';
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
    "vm.admin_reserve_kbytes" = 262144;
  };

  system.autoUpgrade = {
  enable = true;
  flake = "/home/${userSettings.username}/cutie-dotfiles"; 
  flags = [
    "--update-input" "nixpkgs"
    "--commit-lock-file"
  ];
  dates = "weekly";
  randomizedDelaySec = "45min";
  };

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        initial_cpu_governor = "performance";
        default_cpu_governor = "balanced";
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'Oyun Modu Aktif'";
        stop = "${pkgs.libnotify}/bin/notify-send 'Oyun Modu Kapalı'";
      };
    };
  };

  services.flatpak.enable = true;

  users.users."${userSettings.username}" = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [
      "wheel"
      "networkmanager"
      "tailscale"
      "docker"
      "libvirtd"
      "kvm"
    ];
    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];
    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];
  };
  environment.systemPackages = [
    pkgs.nvidia-container-toolkit
    pkgs.gamescope
    pkgs.libnotify
    pkgs.cudaPackages.cudatoolkit
  ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  environment.sessionVariables = {
    STAGING_SHARED_MEMORY = "1";
    PROTON_ASYNC = "1";
  };

  system.stateVersion = "25.11";
}
