{ pkgs, ... }:
{
  # 1. Greetd (Giriş Yöneticisi Servisi) Aktifleştirme
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # ReGreet arayüzünü Cage (minimal Wayland compositi) ile güvenli bir şekilde başlatır
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };
    };
  };

  # 2. ReGreet Arayüzünün Tamamen Catppuccin ve Font Ayarları
  programs.regreet = {
    enable = true;

    # Yazı Tipi Ayarları
    font = {
      package = pkgs.jetbrains-mono;
      name = "JetBrains Mono";
      size = 12;
    };

    # Tema ve İkon Paketleri (Burada tam senin verdiğin alt option'ları kullandık)
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        variant = "mocha";
      };
      name = "catppuccin-mocha-lavender-standard+semibold";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    cursorTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    # ReGreet İç Tasarım Ayarları (Giriş ekranı açıldığında ne göreceksin)
    settings = {
      background = {
        # Duvar kağıdının tam adresi (swww için kullandığımız o Catppuccin Mocha görseli)
        path = "/home/flaouve/.config/assets/images/wallpaper.png";
        fit = "Cover";
      };
      GTK = {
        application_prefer_dark_theme = true;
      };
    };
  };

  # Cage paketinin sistemde kurulu olduğundan emin olalım (Giriş ekranını çizebilmesi için)
  environment.systemPackages = [ pkgs.cage ];
}
