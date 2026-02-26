{ ... }:
{
  services.cockpit = {
    enable = true;
    openFirewall = true;
    port = 9090;
    showBanner = true;
    settings = {
      WebService = {
        Origins = "http://localhost:9090 http://127.0.0.1:9090";
      };
    };

  };
}
