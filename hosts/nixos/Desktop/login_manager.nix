{
  pkgs,
  userSettings,
  systemSettings,
  ...
}:
{

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${userSettings.username}";

  services.displayManager.defaultSession = "${systemSettings.desktop}";

  programs.dconf.enable = true;

  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=Papirus-Dark
  '';
  environment.etc."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-icon-theme-name=Papirus-Dark
  '';

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "gnome"; # Fontları ve ayarları "gnome" portalından çekmesini söyler
  };

  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
