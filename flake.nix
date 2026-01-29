{
  description = "Benim ilk Nix Flake projem";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: 
  let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        
        userSettings = {
          username = "kullanici_adin";
          name = "Senin Adın";
          email = "eposta@adresin.com";
          dotfilesDir = "~/.cutie-dotfiles"; 
        };
      in {
        homeConfigurations."${userSettings.username}" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # Bu satır değişkenleri home.nix (user.nix) içine gönderir
          extraSpecialArgs = { inherit userSettings; }; 
          modules = [ ./home/user.nix ];
        };
      };
}