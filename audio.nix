# audio.nix: PipeWire and audio stack configuration
{ config, pkgs, lib, ... }:
{
  ############################
  # Audio System
  ############################
  # Disable PulseAudio (using PipeWire instead)
  services.pulseaudio.enable = false;

  # Enable realtime kit for audio processing
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
