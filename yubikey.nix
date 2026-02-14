# yubikey.nix: U2F/YubiKey PAM configuration and management tools
{ config, pkgs, ... }:

{
  ############################
  # U2F/PAM Configuration
  ############################
  security.pam.u2f = {
    enable = true;
    control = "sufficient";  # Allows YubiKey OR password
    # control = "required";  # Would require YubiKey AND password
  };

  ############################
  # YubiKey Management Tools
  ############################
  environment.systemPackages = with pkgs; [
    pam_u2f
    yubikey-manager
    yubikey-personalization
  ];
}
