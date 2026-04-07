# nvidia.nix

{ config, pkgs, lib, ... }:
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
}
