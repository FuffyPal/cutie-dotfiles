{ pkgs, userSettings, ... }: {
  
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";

  home.stateVersion = "25.11"; 

  home.packages = with pkgs; [
    helix
    lolcat
    bat
  ];

  programs.bash = {
      enable = true;
      enableCompletion = true;
      historySize = 1000;
      historyControl = [ "ignoredups" "erasedups" ];
      shellAliases = {
        ll = "ls -lh";
        la = "ls -lha";
        cat = "lolcat";
        hx = "helix"; 
        helix = "helix";
      };
  
      bashrcExtra = ''
        # Sadece Nix'in otomatik yapamadığı "Görsel" ve "Dış Kaynaklı" ayarlar:
        
        # Renkli Prompt (Kişisel zevk)
        PS1="\[\e[38;2;255;171;185m\]\u@\h \[\e[38;2;180;200;255m\]\w\[\e[0m\]\$ "
  
        # Eğer bu dosya GitLab'da yoksa hata almamak için kontrol ekledik
        [ -f "$HOME/.alias" ] && source "$HOME/.alias"
      '';
    };
    
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