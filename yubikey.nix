# yubikey.nix

{ pkgs, ... }:

{
  ############################
  # U2F/PAM Configuration
  ############################
  security.pam.u2f = {
    enable = true;
    control = "sufficient";  # Allows YubiKey OR password
    # control = "required";  # Would require YubiKey AND password
    settings.cue = true;     # Print "Please touch the device" instead of hanging
  };

  # Keep the key out of the *login* path: with `sufficient`, a key touch at
  # SDDM logs you in without a password, which leaves gnome-keyring locked.
  # sudo, polkit and hyprlock still accept the key.
  security.pam.services.sddm.u2f.enable  = false;
  security.pam.services.login.u2f.enable = false;

  ############################
  # Smart card daemon
  ############################
  # Needed for `ykman oath/piv/openpgp` (the CCID applets)
  services.pcscd.enable = true;

  ############################
  # YubiKey Management Tools
  ############################
  environment.systemPackages = with pkgs; [
    pam_u2f           # provides pamu2fcfg for registering keys
    yubikey-manager
  ];
}
