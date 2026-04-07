# audio.nix

{ config, pkgs, lib, ... }:
{
  ############################
  # Audio System
  ############################
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  ############################
  # PipeWire Configuration
  ############################
  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;
    # jack.enable     = true;
  };
}
