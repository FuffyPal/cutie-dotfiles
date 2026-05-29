{
  systemSettings,
  userSettings,
  config,
  ...
}:
{

  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;
  services.zapret = {
    enable = true;
    params =
      if systemSettings.hostname == "cutie" then
        [
          "--dpi-desync=fake,split2"
          "--dpi-desync-ttl=1"
          "--dpi-desync-fooling=badsum,md5sig"
          "--dpi-desync-autottl=2"
          "--dpi-desync-split-pos=midsld+1"
          #"--dpi-desync-udp=fake"
          #"--dpi-desync-udp-mdisorder=3"
        ]
      else if systemSettings.hostname == "retrex" then
        [
          "--dpi-desync=fake"
          "--dpi-desync-ttl=1"
          "--dpi-desync-fooling=badsum,md5sig"
          "--dpi-desync-autottl=-1"
          "--dpi-desync-split-pos=1"
        ]
      else
        [ "--dpi-desync=fake" ];
    whitelist = [
      "*.fluffypal.me"
      "fluffypal.me"
    ];
  };
  services.openssh = {
    enable = false;
    settings = {
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
      PermitRootLogin = "no";
    };
    openFirewall = false;
  };

  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--ssh"
      "--exit-node-allow-lan-access"
    ];
    extraSetFlags = [
      "--operator=${userSettings.username}"
    ];
  };

  services.resolved = {
    enable = true;
    dnssec = "true";
    dnsovertls = "true";
    extraConfig = ''
      [Resolve]
      DNS=1.1.1.1#cloudflare-dns.com 9.9.9.9#dns.quad9.net
      FallbackDNS=1.0.0.1#cloudflare-dns.com 149.112.112.112#dns.quad9.net
      Cache=yes
      CacheFromLocalhost=no
      ReadEtcHosts=yes
    '';
  };
  programs.alvr.openFirewall = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.dedicatedServer.openFirewall = true;
  networking.firewall = {
    enable = true;
    allowPing = true;
    checkReversePath = "loose";
    trustedInterfaces = [ "tailscale0" ];
    allowedTCPPorts = [
      53317 # localsend
      4955 # warframe
      4950 # warframe
      27031 # Steam Remote Play
      27036 # Steam Remote Play
      27037 # Steam Remote Play
    ];
    allowedUDPPorts = [
      config.services.tailscale.port
      53317 # localsend
      4955 # warframe
      4950 # warframe
      27031 # Steam Remote Play
      27036 # Steam Remote Play
      27037 # Steam Remote Play
    ];
    allowedTCPPortRanges = [
      {
        from = 1714; # kdeconnect
        to = 1764; # kdeconnect
      }
    ];
    allowedUDPPortRanges = [
      {
        from = 1714; # kdeconnect
        to = 1764; # kdeconnect
      }
    ];
  };
}
