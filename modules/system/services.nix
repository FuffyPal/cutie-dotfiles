{ config, pkgs, systemSettings, userSettings, ... }:
let
  xdg = config.xdg.userDirs;
in
{
  services.syncthing = {
    enable = true;
    user = "${userSettings.username}";
    dataDir = "/home/${userSettings.username}/Documents";    
    configDir = "/home/${userSettings.username}/.config/syncthing"; 
    settings.devices."pal".id = "${systemSettings.syncthingId}";
    settings.folders = {
      "Music" = {
        path = "${xdg.music}";
        devices = [ "pal" ];
      };
      "Videos" = {
        path = "${xdg.videos}";
        devices = [ "pal" ];
      };
      "Pictures" = {
        path = "${xdg.pictures}";
        devices = [ "pal" ];
      };
      "Documents" = {
        path = "${xdg.documents}";
        devices = [ "pal" ];
      }; 
      "Joplin" = {
        path = "/home/${userSettings.username}/Sync/joplin";
        devices = [ "pal" ];
      };
      "Sec" = {
        path = "/home/${userSettings.username}/Sync/sec";
        devices = [ "pal" ];
      };
    };
  };
  system.activationScripts.syncthingDirs = {
    text = ''
      mkdir -p /home/${userSettings.username}/Sync/joplin
      mkdir -p /home/${userSettings.username}/Sync/sec
      chown -R ${userSettings.username}:users /home/${userSettings.username}/Sync
    '';
  };
}