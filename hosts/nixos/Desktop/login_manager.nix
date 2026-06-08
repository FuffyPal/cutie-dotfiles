{ pkgs, userSettings, ... }: {

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${userSettings.username}";

  services.displayManager.defaultSession = "niri";

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
    config.common.default = "gnome"; # Fontları ve ayarları "gnome" portalından çekmesini söyler
  };

  services.gvfs.enable = true;
  services.gnome.gnome-keyring.enable = true;
}
