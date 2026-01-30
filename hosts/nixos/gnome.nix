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
    simple-scan
    showtime
    snapshot
    decibels
    papers
    gnome-console
  ]);

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-weather
    gnome-terminal
    gnomeExtensions.appindicator
    gnomeExtensions.battery-health-charging
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.color-picker
    gnomeExtensions.compiz-windows-effect
    gnomeExtensions.dash-to-dock
    gnomeExtensions.tiling-shell
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    gnomeExtensions.weather-oclock
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.media-controls
    gnomeExtensions.wiggle
  ];
  xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "gnome";
    };
}