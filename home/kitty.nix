{
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    shellIntegration = {
      enableFishIntegration = true;
      enableZshIntegration = true;
    };

    settings = {
      hide_window_decorations = "yes";

      confirm_os_window_close = "0";
      cursor_trail = "1";
      scrollback_lines = "2000";
      enable_audio_bell = "no";
      window_padding_width = "15";

      background_opacity = "0.90";
      background_blur = "24";
    };

    extraConfig = ''
      mouse_map alt+left press ungrabbed mouse_selection rectangle
    '';
  };
}
