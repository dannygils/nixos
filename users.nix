# users.nix

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
      "dialout"
      "uucp"
    ];
    
    # Per-user packages (optional)
    packages = with pkgs; [
      # Optional: user-scoped packages; you can keep this empty.
      # thunderbird
    ];
  };
}
