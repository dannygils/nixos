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
    modesetting.enable = true;
    # This machine is never suspended (no sleep events in the journal),
    # so the suspend/resume hooks are not needed.
    powerManagement.enable = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
    # RTX 3090 Ti (Ampere) supports the open modules; the proprietary ones
    # still build and work on this branch, so leaving as-is. Flip to true if
    # a future driver drops proprietary support for Turing+.
    open = false;
    # Keeps the driver initialised so the GPU doesn't re-init per client
    nvidiaPersistenced = true;
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
  # No LD_LIBRARY_PATH here: a session-wide value leaks into every child
  # process (Steam runtime, 32-bit apps, nix-shell). Nix-built programs that
  # need the driver already have /run/opengl-driver/lib in their RUNPATH.
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME         = "nvidia";
    NVD_BACKEND               = "direct";
    GBM_BACKEND               = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };
}
