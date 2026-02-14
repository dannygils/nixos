# users.nix: User accounts and per-user package lists
{ config, pkgs, lib, ... }:
{
  ############################
  # User Accounts
  ############################
  users.users.dan = {
    isNormalUser = true;
    description  = "dan";
    
    # System groups
    extraGroups  = [
      "networkmanager"  # Network management
      "wheel"           # Sudo access
  #   "docker"          # Docker access (virtualisation.docker.enable in programs.nix)
    ];
    
    # Per-user packages (optional)
    packages = with pkgs; [
      # Optional: user-scoped packages; you can keep this empty.
      # thunderbird
    ];
  };
}
