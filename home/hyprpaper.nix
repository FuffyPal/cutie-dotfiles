{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [ ../../assets/images/wallpaper.png ];
      wallpaper = [ ",${../../assets/images/wallpaper.png}" ];
    };
  };
}
