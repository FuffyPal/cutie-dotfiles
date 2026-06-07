{ pkgs, ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=12";
        terminal = "${pkgs.kitty}/bin/kitty";
        prompt = "❯  ";
        layer = "overlay";

        width = 40;
        tabs = 4;
        horizontal-pad = 20;
        vertical-pad = 15;
        inner-pad = 10;
        # radius = 12;
      };

      colors = {
        background = "1e1e2edd";
        text = "cdd6f4ff";
        match = "f38ba8ff";
        selection = "585b70ff";
        selection-text = "cdd6f4ff";
        selection-match = "f38ba8ff";
        border = "b4befeff";
      };

      border = {
        width = 2;
        radius = 12;
      };
    };
  };
}
