{ pkgs, userSettings, ... }: {
  
  # Değişkenleri burada kullanıyoruz
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
    # Buradaki değerler artık flake.nix'ten geliyor!
    userName = userSettings.name;
    userEmail = userSettings.email;
  };

  programs.home-manager.enable = true;
}