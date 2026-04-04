{
  description = "Benim ilk Nix Flake projem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self,
    nixpkgs-unstable,
    nixpkgs,
    home-manager,
    nix-flatpak,
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
        name = "Fluffy Pal";
        email = "email@email.com";
        dotfilesDir = "~/.cutie-dotfiles";
      };

      cutieSettings = {
        hostname = "cutie";
        timezone = "Europe/Istanbul";
        locale = "de_DE.UTF-8";
        gpuType = "hybrid";
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
        syncthingId = "None"; # dont working because i dont have syncthing installed
      };

      retrexSettings = {
        hostname = "retrex";
        timezone = "Europe/Istanbul";
        locale = "tr_TR.UTF-8";
        gpuType = "nvidia";
        # amdgpuBusId = "PCI:5:0:0";
        # nvidiaBusId = "PCI:1:0:0";
        # syncthingId = "None"; # dont working because i dont have syncthing installed
      };

    in
    {
      nixosConfigurations = {

        "${cutieSettings.hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = { systemSettings = cutieSettings; inherit userSettings; inherit system; inherit pkgs-unstable; };
          modules = [
            ./hosts/nixos/configuration.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = { inherit userSettings; systemSettings = cutieSettings; };
              home-manager.users."${userSettings.username}" = {
                imports = [
                  ./home/user.nix
                  nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            }
          ];
        };

        "${retrexSettings.hostname}" = nixpkgs.lib.nixosSystem {
          specialArgs = { systemSettings = retrexSettings; inherit userSettings; inherit system; inherit pkgs-unstable; };
          modules = [
            ./hosts/nixos/configuration.nix
            nix-flatpak.nixosModules.nix-flatpak
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "bak";
              home-manager.extraSpecialArgs = { inherit userSettings; systemSettings = retrexSettings; };
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
    };
}
