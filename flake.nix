{
  description = "Benim ilk Nix Flake projem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nix-flatpak.url = "github:gmodena/nix-flatpak/";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-flatpak, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      systemSettings = {
        system = "x86_64-linux";
        hostname = "cutie";
        timezone = "Europe/Istanbul";
        locale = "de_DE.UTF-8";
        gpuType = "hybrid"; # AMD + Nvidia = hybrid but Intel+Nvida=Not Support
        # please enter sudo lshw -c display PCI area or lspci | grep -E 'VGA|3D'
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
        syncthingId = "None";
      };
      userSettings = {
        username = "fluffypal";
        name = "Fluffy Pal";
        email = "email@email.com";
        dotfilesDir = "~/.cutie-dotfiles";
      };
    in
    {
      nixosConfigurations."${systemSettings.hostname}" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit systemSettings userSettings; };
        modules = [
          ./hosts/nixos/configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.extraSpecialArgs = { inherit userSettings; };
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
}
