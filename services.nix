# services.nix

{ ... }:
{
  ############################
  # Network Discovery
  ############################
  # nssmdns6 stays off: most mDNS responders publish A records only, so AAAA
  # lookups for *.local just burn a timeout before falling back.
  services.avahi = {
    enable   = true;
    nssmdns4 = true;
    nssmdns6 = false;
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
  # security.polkit.enable is turned on by programs.hyprland (see hyprland.nix)

}
