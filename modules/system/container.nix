{
  userSettings,
  ...
}:

let
  modelBaseDir = "/home/${userSettings.username}/models";
in
{
  virtualisation.oci-containers = {
    backend = "podman";
    containers = {
      comfyui = {
        image = "registry.gitlab.com/fluffypal/comfyui-docker:latest";

        autoStart = false;

        ports = [
          "8188:8188"
        ];
        volumes = [
          "${modelBaseDir}:/models"
        ];

        extraOptions = [
          "--network=slirp4netns"
          "--device=nvidia.com/gpu=all"
          "--security-opt=label=disable"
          "--user=${userSettings.username}"
        ];
      };
    };
  };

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  users.users."${userSettings.username}".extraGroups = [ "podman" ];
}
