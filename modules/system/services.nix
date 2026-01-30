{ config, pkgs, systemSettings, userSettings, ... }:
{

  services.syncthing = {
    enable = true;
    user = "${userSettings.username}";
    dataDir = "/home/${userSettings.username}/Documents";    
    configDir = "/home/${userSettings.username}/.config/syncthing"; 
    settings.devices."pal".id = "${systemSettings.syncthingId}";
    settings.folders = {
      "Music" = {
        path = "/home/${userSettings.username}/Music";
        devices = [ "pal" ];
      };
      "Videos" = {
        path = "/home/${userSettings.username}/Videos";
        devices = [ "pal" ];
      };
      "Pictures" = {
        path = "/home/${userSettings.username}/Pictures";
        devices = [ "pal" ];
      };
      "Documents" = {
        path = "/home/${userSettings.username}/Documents";
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