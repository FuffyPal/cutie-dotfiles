{
  disko.devices = {
    disk = {
      my-main-disk = {
        type = "disk";
        device = "/dev/vda";
        content = {
          type = "gpt"; # BIOS olsa bile modern GPT bölme tablosu kullanmak en sağlıklısıdır
          partitions = {
            # 1. BIOS Boot Bölümü (GRUB'ın GPT disklere kurulabilmesi için ŞARTTIR)
            boot = {
              priority = 1;
              size = "1M";
              type = "EF02"; # Kurulum imajlarında GRUB MBR için bu tip aranır
            };

            # 2. 8GB Swap Bölümü
            swap = {
              priority = 2;
              size = "8G";
              content = {
                type = "swap";
                discardPolicy = "both";
              };
            };

            # 3. Kalan Alan: Btrfs Root Dizinleri
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
