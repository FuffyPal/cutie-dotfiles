{ config, systemSettings, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;
      amdgpuBusId = systemSettings.amdgpuBusId;
      nvidiaBusId = systemSettings.nvidiaBusId;
    };
  };

  environment.sessionVariables = {
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_SIZE = "1073741824";
    PROTON_ENABLE_NVAPI = "1";
    DXVK_ENABLE_NVAPI = "1";
  };
  hardware.nvidia-container-toolkit.enable = true;
}
