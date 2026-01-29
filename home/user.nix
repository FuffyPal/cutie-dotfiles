{ pkgs, userSettings, ... }: {
  
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  home.stateVersion = "25.11"; 

  home.packages = with pkgs; [
  ];

  services.flatpak = {
      enable = true;
      packages = [
        "io.gitlab.librewolf-community"
        "com.github.rafostar.Clapper"
        "org.localsend.localsend_app"
        "com.github.tchx84.Flatseal"
        "org.mozilla.Thunderbird"
        "org.gnome.Loupe"
        "im.fluffychat.Fluffychat"
        "de.haeckerfelix.Fragments"
        "com.spotify.Client"
        "io.ente.auth"
        "net.cozic.joplin_desktop"
      ];
      update.auto.enable = true;
      uninstallUnmanaged = true; # Nix listesinde olmayanları siler (isteğe bağlı)
    };
  
  
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