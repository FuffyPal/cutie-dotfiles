{ systemSettings
, userSettings
, config
, ...
}:
{

  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;
  services.zapret = {
    enable = true;
    params = [
      "--dpi-desync=fake"
      "--dpi-desync-ttl=1"
      "--dpi-desync-fooling=badsum,md5sig"
      "--dpi-desync-autottl=-1"
    ];
    whitelist = [
      "discord.com"
      "fluffypal.me"
    ];
  };
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--operator=${userSettings.username}" ];
  };
  services.resolved = {
    enable = true;
    dnssec = "allow-downgrade";
    dnsovertls = "opportunistic";
    extraConfig = ''
      [Resolve]
      DNS=1.1.1.1#cloudflare-dns.com 9.9.9.9#dns.quad9.net
      FallbackDNS=1.0.0.1#cloudflare-dns.com 149.112.112.112#dns.quad9.net
      MulticastDNS=no
      LLMNR=no
      Cache=yes
      CacheFromLocalhost=no
      DNSStubListener=yes
      ReadEtcHosts=yes
      ResolveUnicastSingleLabel=no
      StaleRetentionSec=0
    '';
  };
  networking.firewall = {
    enable = true;
    allowPing = true;
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [
      22000
      53317
      139
      445
      8080
    ];
    allowedUDPPorts = [
      config.services.tailscale.port
      53317
      22000
      21027
      27031
      137
      27036
      138
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
      {
        from = 27036;
        to = 27037;
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
      {
        from = 10400;
        to = 10401;
      }
    ];
  };
}
