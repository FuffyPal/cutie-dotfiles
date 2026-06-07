{ ... }:

{
  systemd.oomd = {
    enable = true;
    enableUserSlices = true;
    enableRootSlice = false;
    enableSystemSlice = false;
  };
}