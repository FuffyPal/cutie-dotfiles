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
  virtualisation.containers.policy = {
    default = [ { type = "insecureAcceptAnything"; } ];
  };
  systemd.user.extraConfig = ''
    DefaultEnvironment="PATH=/run/current-system/sw/bin:/run/wrappers/bin:${lib.makeBinPath [ pkgs.bash ]}"
  '';
}