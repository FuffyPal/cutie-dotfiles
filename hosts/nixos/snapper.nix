{ config, pkgs, ... }:

{
  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1h";    
    
    configs = {
      home = {
        SUBVOLUME = "/home";
        FSTYPE = "btrfs";
        
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;

        TIMELINE_LIMIT_HOURLY = "12";  
        TIMELINE_LIMIT_DAILY = "3";    
        
        TIMELINE_LIMIT_WEEKLY = "0";
        TIMELINE_LIMIT_MONTHLY = "0";
        TIMELINE_LIMIT_YEARLY = "0";
        
        ALLOW_USERS = [ "fluffypal" ];
      };
    };
  };

  environment.systemPackages = [ pkgs.snapper ];
}