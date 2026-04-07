# services.nix

{ config, pkgs, lib, ... }:
{
  ############################
  # Printing
  ############################
  services.printing.enable = true;

  ############################
  # Network Discovery
  ############################
  services.avahi = {
    enable   = true;
    nssmdns4 = true;
    nssmdns6 = true;
  };

  ############################
  # File Manager Services
  ############################
  # Needed for Nautilus to handle sftp://, smb://, etc.
  services.gvfs.enable = true;

  # Needed for GUI mounting of local drives (Nautilus, etc.)
  services.udisks2.enable = true;

  ############################
  # Authorization
  ############################
  # Enable system-wide PolicyKit
  security.polkit.enable = true;

}