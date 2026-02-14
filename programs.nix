# programs.nix: High-level programs and services

{ config, pkgs, lib, ... }:
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
  programs.adb.enable = true;
  users.users.dan.extraGroups = [ "adbusers" "kvm" ];
  # services.udev.packages = [ pkgs.android-udev-rules ];  # Optional udev rules

  ############################
  # Notes
  ############################
  # To load Chromium once with flakes - This is for when I need to use web-based phone flashing:
  # nix run "nixpkgs#chromium" --extra-experimental-features nix-command --extra-experimental-features flakes
}
