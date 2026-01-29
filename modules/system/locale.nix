{ systemSettings, ... }: {
  time.timeZone = systemSettings.timezone;
  i18n.defaultLocale = systemSettings.locale;
  
  # Klavye düzeni
  services.xserver.xkb = {
    layout = "tr";
    variant = "";
  };
  
  console.keyMap = "trq";
}