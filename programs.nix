# programs.nix

{ ... }:
{
  ############################
  # Desktop Applications
  ############################
  programs.firefox.enable = true;
  programs.dconf.enable   = true;

  ############################
  # Shell Utilities
  ############################
  programs.zoxide.enable  = true;

  ############################
  # Gaming - Steam
  ############################
  programs.steam = {
    enable = true;
    remotePlay.openFirewall                = true;
    dedicatedServer.openFirewall           = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  ############################
  # Virtualization
  ############################
  # virtualisation.docker.enable = true;

  ############################
  # Android Development
  ############################
  users.users.dan.extraGroups = [ "kvm" "input" ];
  # services.udev.packages = [ pkgs.android-udev-rules ];  # Optional udev rules

  ############################
  # udev rules
  ############################
  services.udev.extraRules = ''
    # streamcontroller
    KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess", GROUP="input", MODE="0660"
    # Neato XV-21 -> /dev/neato
    SUBSYSTEM=="tty", ATTRS{idVendor}=="2108", ATTRS{idProduct}=="780b", SYMLINK+="neato", MODE="0660", GROUP="dialout"
  '';


  ############################
  # Notes
  ############################
  # To load Chromium once with flakes - This is for when I need to use web-based phone flashing:
  # nix run "nixpkgs#chromium" --extra-experimental-features nix-command --extra-experimental-features flakes
}
