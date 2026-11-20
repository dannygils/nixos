# controllers.nix

{ ... }:

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
    # Prevent DualSense touchpad from acting like a laptop touchpad.
    # Wildcarded because the "Sony Interactive Entertainment" prefix is only
    # present over USB; over Bluetooth the name starts at "DualSense".
    SUBSYSTEM=="input", ATTRS{name}=="*DualSense*Touchpad", ENV{ID_INPUT_TOUCHPAD}="", ENV{ID_INPUT_MOUSE}="", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}