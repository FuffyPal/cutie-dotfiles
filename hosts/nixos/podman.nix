{ pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  virtualisation.containers.registries.search = [ 
    "docker.io"
    "ghcr.io"
    "quay.io"
    "registry.gitlab.com"
  ];
}
