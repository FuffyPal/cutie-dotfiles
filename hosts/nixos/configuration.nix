{ pkgs, systemSettings, userSettings, ... }: {
  imports = [
    ./hardware.nix
    ./gnome.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
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
  system.autoUpgrade = {
    enable = true;
    flake = "github:FuffyPal/cutie-dotfiles";
    flags = [
      "--update-input" "nixpkgs"
      "--commit-lock-file"
    ];
    dates = "04:00";
    randomizedDelaySec = "45min";
  };
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };
  
  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
  };
  
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        initial_cpu_governor = "performance";
        default_cpu_governor = "balanced"; 
      };
    };
  };
  
  services.flatpak.enable = true;

  users.users."${userSettings.username}" = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "25.11";
}