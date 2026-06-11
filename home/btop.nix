{
  programs.btop = {
    enable = true;

    settings = {
      color_theme = "catppuccin_mocha";

      theme_background = false;

      update_ms = 1500;
      proc_sorting = "cpu lazy";
      proc_reversed = false;
      proc_tree = true;
      graph_symbol = "braille";
      shown_boxes = "cpu mem net proc";
    };

  };
}
