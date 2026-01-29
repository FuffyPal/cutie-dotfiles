{ pkgs, systemSettings, userSettings, ... }: {
  imports = [
    ./hardware.nix
    ./gnome.nix
    ../../modules/system/locale.nix
    ../../modules/system/networking.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  services.flatpak.enable = true;

  users.users."${userSettings.username}" = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "25.11";
}