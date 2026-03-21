{ pkgs, userSettings , ... }: {
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${userSettings.username}";
  services.gvfs.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  programs.dconf.enable = true;

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
    gnome.gvfs
    gvfs
    gnome-online-accounts
    libgnome-keyring
    gnome-tweaks
    gnome-weather
    gnomeExtensions.appindicator
    gnomeExtensions.battery-health-charging
    gnomeExtensions.bluetooth-battery-meter
    gnomeExtensions.blur-my-shell
    gnomeExtensions.caffeine
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.color-picker
    gnomeExtensions.dash-to-dock
    gnomeExtensions.gsconnect
    gnomeExtensions.just-perfection
    gnomeExtensions.weather-oclock
    gnomeExtensions.media-controls
    gnomeExtensions.quick-settings-audio-panel
    gnomeExtensions.quick-settings-touchpad-toggle
    gnomeExtensions.restart-to
    gnomeExtensions.forge
    gnomeExtensions.user-avatar-in-quick-settings
  ];
  xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "gnome";
    };
}
