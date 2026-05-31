{ pkgs, ... }:

{
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
    kubectl
    nvidia-container-toolkit
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
