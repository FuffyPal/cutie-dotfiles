{ pkgs, ... }:

{
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    podman-compose
  ];
  virtualisation.containers.registries.search = [
    "docker.io"
    "quay.io"
    "registry.fedoraproject.org"
  ];
  hardware.nvidia-container-toolkit.enable = true;
  security.unprivilegedUsernsClone = true;
}