{
  description = "Benim ilk Nix Flake projem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs-unstable,
      nixpkgs,
      home-manager,
      nix-flatpak,
      disko,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      userSettings = {
        username = "flaouve";
        name = "flaouve";
        email = "flaouve@gmail.com";
        dotfilesDir = "~/.cutie-dotfiles";
      };

      # serverSettings = {
      #   cockpit = true;
      # };

      cutieSettings = {
        hostname = "cutie";
        timezone = "Europe/Istanbul";
        locale = "de_DE.UTF-8";
        gpuType = "hybrid";
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
        desktop = "niri";
        biosmode = "efi";
        disk = "nvme0n1"; # lsblk output
      };

      # virtualSettings = {
      #   hostname = "virtual";
      #   timezone = "Europe/Istanbul";
      #   locale = "de_DE.UTF-8";
      #   disk = "vda"; # lsblk output
      #   gpuType = "a";
      #   amdgpuBusId = "PCI:5:0:0";
      #   nvidiaBusId = "PCI:1:0:0";
      #   desktop = "s";
      #   biosmode = "efi";
      # };

      # violet1Settings = {
      #   hostname = "eu-violet-1";
      #   timezone = "Europe/Istanbul";
      #   locale = "de_DE.UTF-8";
      #   gpuType = "none";
      #   disk = "sda"; # lsblk output
      #   desktop = "none";
      #   biosmode = "legacy";
      # };

      itFedoraSettings = {
        hostname = "it";
        timezone = "Europe/Istanbul";
        locale = "de_DE.UTF-8";
        gpuType = "hybrid";
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
        desktop = "gnome";
      };

      retrexSettings = {
        hostname = "retrex";
        timezone = "Europe/Istanbul";
        locale = "tr_TR.UTF-8";
        gpuType = "nvidia";
        desktop = "gnome";
        disk = "none"; # lsblk output
        biosmode = "efi";
      };

    in
    {
      nixosConfigurations = {

        "${cutieSettings.hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            systemSettings = cutieSettings;
            inherit userSettings;
            inherit system;
            inherit pkgs-unstable;
            # inherit serverSettings;
          };
          modules = [
            ./hosts/nixos/Desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = {
                inherit userSettings;
                systemSettings = cutieSettings;
                inherit pkgs-unstable;
              };
              home-manager.users."${userSettings.username}" = {
                imports = [
                  ./home/user.nix
                  nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            }
          ];
        };

        # "${virtualSettings.hostname}" = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     systemSettings = virtualSettings;
        #     inherit userSettings;
        #     inherit system;
        #     inherit pkgs-unstable;
        #   };
        #   modules = [
        #     ./hosts/nixos/Desktop/configuration.nix
        #     disko.nixosModules.disko
        #     ./hosts/nixos/Desktop/disk-config.nix
        #   ];
        # };

        "${retrexSettings.hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = {
            systemSettings = retrexSettings;
            inherit userSettings;
            inherit system;
            inherit pkgs-unstable;
          };
          modules = [
            ./hosts/nixos/Desktop/configuration.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = {
                inherit userSettings;
                systemSettings = retrexSettings;
                inherit pkgs-unstable;
              };
              home-manager.users."${userSettings.username}" = {
                imports = [
                  ./home/user.nix
                  nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            }
          ];
        };
      };
      homeConfigurations = {
        "${userSettings.username}" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };

          extraSpecialArgs = {
            inherit userSettings;
            systemSettings = itFedoraSettings;
            inherit pkgs-unstable;
          };

          modules = [
            ./home/user.nix
            nix-flatpak.homeManagerModules.nix-flatpak
            {
              home.username = userSettings.username;
              home.homeDirectory = "/home/${userSettings.username}";
              home.stateVersion = "25.11";
            }
          ];
        };
      };
    };
}
