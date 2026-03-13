{ pkgs, userSettings , ... }: {
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${userSettings.username}";

  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-music
    gnome-maps
    gnome-contacts
    gnome-clocks
    gnome-calendar
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
  ]);

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-weather
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
    gnomeExtensions.media-controls
    gnomeExtensions.quick-settings-audio-panel
  ];
  xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "gnome";
    };
}
