{ pkgs, ... }: {
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour 
    gnome-music 
    gnome-maps 
    gnome-contacts 
    gnome-clocks 
    gnome-software
    geary 
    epiphany 
    cheese 
    gnome-calculator
  ]);

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-weather
  ];
}