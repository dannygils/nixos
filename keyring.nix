# keyring.nix

{ ... }:

{
  ############################
  # Keyring Service
  ############################
  services.gnome.gnome-keyring.enable = true;

  ############################
  # Keyring Management GUI
  ############################
  programs.seahorse.enable = true;
}
