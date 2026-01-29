{ pkgs, userSettings, ... }: {
  
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  home.stateVersion = "25.11"; 

  home.packages = with pkgs; [
    neofetch
    htop
    bat
    eza
  ];

  programs.git = {
    enable = true;
    settings = {
          user = {
            name = userSettings.name;
            email = userSettings.email;
          };
        };
      };
  programs.home-manager.enable = true;
}