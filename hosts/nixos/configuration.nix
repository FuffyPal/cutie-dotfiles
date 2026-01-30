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
  
  services.flatpak.enable = true;

  users.users."${userSettings.username}" = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "25.11";
}