{ pkgs, ... }:

{
  virtualisation.containers.enable = true;

  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
    autoPrune.enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
    kubectl
  ];

  virtualisation.containers.registries.search = [
    "docker.io"
    "quay.io"
    "ghcr.io"
    "gcr.io"
    "registry.gitlab.com"
    "registry.fedoraproject.org"
    "registry.access.redhat.com"
  ];

  security.unprivilegedUsernsClone = true;
}
