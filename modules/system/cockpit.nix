{ ... }:
{
  services.cockpit = {
    enable = true;
    openFirewall = true;
    port = 9090;
    showBanner = true;

  };
}
