# services.nix: Misc system services (printing, Avahi, optional SSH/firewall)
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
  # Enable system-wide PolicyKit (needed to authorize udisks2 actions)
  security.polkit.enable = true;

  ############################
  # Optional Services
  ############################
  # Example firewall/SSH toggles:
  # services.openssh.enable = true;
  # networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ 22 80 443 ];
}
