# nvidia.nix: NVIDIA driver, modesetting, and 32-bit graphics settings
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
    open                   = false;  # Required on NixOS 25.05+ with driver >= 560
  };

  ############################
  # Graphics Support
  ############################
  hardware.graphics.enable      = true;
  hardware.graphics.enable32Bit = true;  # Needed for 32-bit games/applications
}
