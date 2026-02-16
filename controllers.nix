# controllers.nix: Game controller firmware, udev rules, and Steam Input setup
{ config, pkgs, ... }:

{
  ############################
  # Controller Firmware
  ############################
  hardware.enableRedistributableFirmware = true;

  ############################
  # Controller udev Rules
  ############################
  # Prevent DualSense touchpad from being treated as a mouse/touchpad
  services.udev.extraRules = ''
    # Prevent DualSense touchpad from acting like a laptop touchpad
    SUBSYSTEM=="input", ATTRS{name}=="Sony Interactive Entertainment DualSense Wireless Controller Touchpad", ENV{ID_INPUT_TOUCHPAD}="", ENV{ID_INPUT_MOUSE}="", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}