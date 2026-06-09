{
  systemSettings,
  ...
}:
{
  disko.devices = {
    disk = {
      my-disk = {
        type = "disk";
        device = "/dev/${systemSettings.disk}";
        content = {
          type = "gpt";
          partitions = {
            boot =
              if systemSettings.biosmode == "efi" then
                {
                  priority = 1;
                  name = "ESP";
                  size = "500M";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                }
              else
                {
                  priority = 1;
                  name = "bootMBR";
                  size = "1M";
                  type = "EF02";
                };

            swap = {
              priority = 2;
              size = "8G";
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            };

            root = {
              priority = 3;
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@cache" = {
                    mountpoint = "/var/cache";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
