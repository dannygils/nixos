# nvidia.nix

{ config, pkgs, ... }:
{
  ############################
  # NVIDIA Video Driver
  ############################
  services.xserver.videoDrivers = [ "nvidia" ];

  ############################
  # NVIDIA Configuration
  ############################
  hardware.nvidia = {
    modesetting.enable     = true;
    powerManagement.enable = false;
    nvidiaSettings         = true;
    package                = config.boot.kernelPackages.nvidiaPackages.latest;
    open                   = false;
  };

  ############################
  # Graphics Support
  ############################
  hardware.graphics.enable      = true;
  hardware.graphics.enable32Bit = true;
  hardware.graphics.extraPackages = with pkgs; [
    nvidia-vaapi-driver   # VA-API -> NVDEC bridge for hardware video decode
  ];

  ############################
  # Environment: VA-API + EGL
  ############################
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME         = "nvidia";
    NVD_BACKEND               = "direct";
    GBM_BACKEND               = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
