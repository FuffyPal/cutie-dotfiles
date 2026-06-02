{ ... }:
{
  services.cockpit = {
    enable = true;
    openFirewall = false;
    plugins = [

    ];
    allowed-origins = [
      "https://[::1]:9090"
      "https://localhost:9090"
      "http://localhost:9090"
      "https://127.0.0.1:9090"
      "http://127.0.0.1:9090"
    ];
  };
}
