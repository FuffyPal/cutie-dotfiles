{
  systemSettings,
  userSettings,
  system,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  imports = [
    ./hardware.nix
    ../../../modules/system/locale.nix
    ../../../modules/system/networking.nix
    ../../../modules/system/services.nix
    ../../../modules/system/fonts.nix
    ./customize.nix
  ]
  ++ (
    if systemSettings.gpuType == "hybrid" then
      [ ./nvidia_hybrit.nix ]
    else if systemSettings.gpuType == "nvidia" then
      [ ./nvidia.nix ]
    else
      [ ]
  )
  ++ (
    if (systemSettings.hostname == "cutie") then
      [
        #../../modules/system/ananicy.nix
        ../../../modules/system/systemd-oomd.nix
        # ../../../modules/system/cockpit.nix
        #../../modules/system/container.nix
        ../../../modules/system/virt-manager.nix
        #./docker.nix
        ./podman.nix
        ./snapper.nix
        #../../modules/system/lto.nix
      ]
    else
      [ ]
  )
  ++ (
    if (systemSettings.desktop == "gnome") then
      [
        ./gnome.nix
      ]
    # else if (systemSettings.desktop == "hyprland") then
    #   [
    #     ./hyprland.nix
    #   ]
    else if (systemSettings.desktop == "niri") then
      [
        ./niri.nix
      ]
    else
      [ ]
  );

  # FIX: OpenRazer driver compilation error (kernel expects 6 arguments, but code provides 5)
  # Owww Sorry but wait
  # hardware.openrazer.enable = true;
  # hardware.openrazer.users = [ "${userSettings.username}" ];

  boot.kernelPackages =
    if systemSettings.hostname == "cutie" then
      pkgs-unstable.linuxPackages_latest
    else
      pkgs.linuxPackages;

  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "loglevel=3"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "udev.log_priority=3"
    "transparent_hugepages=always"
    "split_lock_detect=off"
    "preempt=full"
  ];
  boot.consoleLogLevel = 0;
  boot.initrd.verbose = false;
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 10;
    timeout = 3;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  system.activationScripts.userAvatar = {
    text = ''
      mkdir -p /var/lib/AccountsService/icons
      mkdir -p /var/lib/AccountsService/users

      cp ${../../../assets/images/avatar.jpg} /var/lib/AccountsService/icons/${userSettings.username}

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
    memoryPercent = 50;
    priority = 100;
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 90;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
    "vm.admin_reserve_kbytes" = 262144;
  };

  services.bpftune.enable = true;

  system.autoUpgrade = {
    enable = true;
    flake = "/home/${userSettings.username}/cutie-dotfiles";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    dates = "weekly";
    randomizedDelaySec = "45min";
  };

  services.cloudflare-warp.enable = true;

  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        initial_cpu_governor = "performance";
        default_cpu_governor = "balanced";
      };
      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'Game Mod Enable'";
        stop = "${pkgs.libnotify}/bin/notify-send 'Game Mod Disable'";
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
      "podman"
      "video"
      "render"
    ];
  };
  environment.systemPackages = [
    pkgs.nvidia-container-toolkit
    pkgs.gamescope
    pkgs.libnotify
    pkgs.cudaPackages.cudatoolkit
    pkgs.btrfs-assistant
    pkgs.bpftune
    # pkgs.polychromatic i forgeet openrazer disabled
  ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.nix-ld.enable = true; # test

  environment.sessionVariables = {
    STAGING_SHARED_MEMORY = "1";
    PROTON_ASYNC = "1";
  };

  system.stateVersion = "26.05";
}
