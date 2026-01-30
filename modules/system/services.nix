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
        id = "2b9rx-xkurd";
        path = "/home/${userSettings.username}/Music";
        devices = [ "pal" ];
      };
      "Videos" = {
        id = "pgdd4-ddwkm";
        path = "/home/${userSettings.username}/Videos";
        devices = [ "pal" ];
      };
      "Pictures" = {
        id = "h5vho-ht2o2";
        path = "/home/${userSettings.username}/Pictures";
        devices = [ "pal" ];
      };
      "Documents" = {
        id = "s2q4h-pqhiz";
        path = "/home/${userSettings.username}/Documents";
        devices = [ "pal" ];
      };
      "Joplin" = {

        path = "/home/${userSettings.username}/Sync/joplin";
        devices = [ "pal" ];
      };
      "Sec" = {
        id = "a74cx-jd4jh";
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
