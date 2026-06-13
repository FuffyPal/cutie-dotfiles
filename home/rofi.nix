{
  pkgs,
  config,
  ...
}:

let
  mkLiteral = config.lib.formats.rasi.mkLiteral;

  bg-col = "#1e1e2edd"; # background
  border-col = "#b4befeff"; # border
  selected-col = "#585b70ff"; # selection
  match-col = "#f38ba8ff"; # match
  fg-col = "#cdd6f4ff"; # text / selection-text
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "JetBrainsMono Nerd Font 12";
    terminal = "${pkgs.kitty}/bin/kitty";

    extraConfig = {
      modi = "run,drun,window";
      icon-theme = "Papirus-Dark";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;

      display-drun = "❯ ";
      display-run = "❯ ";
      display-window = "❯ ";

      sidebar-mode = false;
    };

    theme = {
      "*" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "${fg-col}";
        font = "JetBrainsMono Nerd Font 12";
      };

      "window" = {
        width = mkLiteral "40%";
        border = mkLiteral "2px";
        border-color = mkLiteral "${border-col}";
        background-color = mkLiteral "${bg-col}";
        border-radius = mkLiteral "12px";
      };

      "mainbox" = {
        background-color = mkLiteral "transparent";
        padding = mkLiteral "15px 20px";
        children = mkLiteral "[inputbar, listview]";
      };

      "inputbar" = {
        children = mkLiteral "[prompt,entry]";
        background-color = mkLiteral "transparent";
        padding = mkLiteral "0px 0px 10px 0px";
      };

      "prompt" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "${match-col}";
        padding = mkLiteral "0px 5px 0px 0px";
      };

      "entry" = {
        text-color = mkLiteral "${fg-col}";
        background-color = mkLiteral "transparent";
        placeholder = "Search...";
        placeholder-color = mkLiteral "#585b70ff";
      };

      "listview" = {
        border = mkLiteral "0px";
        padding = mkLiteral "0px";
        margin = mkLiteral "0px";
        columns = 1;
        lines = 8;
        background-color = mkLiteral "transparent";
        spacing = mkLiteral "4px";
      };

      "element" = {
        padding = mkLiteral "6px 10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "${fg-col}";
        border-radius = mkLiteral "8px";
      };

      "element-icon" = {
        size = mkLiteral "24px";
        margin = mkLiteral "0px 10px 0px 0px";
      };

      "element text" = {
        vertical-align = mkLiteral "0.5";
      };

      "element text highlighted" = {
        text-color = mkLiteral "${match-col}";
      };

      "element selected" = {
        background-color = mkLiteral "${selected-col}";
        text-color = mkLiteral "${fg-col}";
      };
    };
  };
}
