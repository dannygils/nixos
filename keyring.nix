# keyring.nix: GNOME Keyring service and Seahorse GUI
{ config, pkgs, ... }:

{
  ############################
  # Keyring Service
  ############################
  # NOTE: Using GNOME Keyring on Hyprland desktop
  services.gnome.gnome-keyring.enable = true;

  ############################
  # Keyring Management GUI
  ############################
  programs.seahorse.enable = true;  # GUI to inspect/manage secrets
}
